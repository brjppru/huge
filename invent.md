# Schema.org / JSON-LD Audit (Hugo + PaperMod)

Дата: 2026-02-10

## Резюме

Текущая Schema.org разметка в теме PaperMod генерируется через `themes/PaperMod/layouts/partials/templates/schema_json.html`, но шаблон выводит значения (строки/URL/даты) без корректного JSON-экранирования и кавычек. В результате `JSON-LD` вероятнее всего невалиден и будет игнорироваться валидаторами и поисковиками.

Дополнительно, генерация schema-скриптов включена только в production-режиме, поэтому на локальном `hugo server` их можно не увидеть.

## Наблюдения

### Критично: JSON-LD невалиден как JSON

Файл: `themes/PaperMod/layouts/partials/templates/schema_json.html`

Примеры мест, где выводятся “сырье” значения без JSON quoting/encoding:
- `"name": {{ site.Title }}` (`schema_json.html:6`)
- `"url": {{ site.Home.Permalink }}` (`schema_json.html:7`)
- `"headline": {{ .Title | plainify }}` (`schema_json.html:67`)
- `"datePublished": {{ .PublishDate }}` (`schema_json.html:93`)

Это должно быть сериализовано как корректные JSON значения (строки в кавычках, даты в ISO-8601, массивы с корректными элементами и запятыми).

### Важно: включается только в production

Подключение schema partial находится в `themes/PaperMod/layouts/partials/head.html` внутри условия production:
- `partial "templates/schema_json.html"` вызывается только при `hugo.IsProduction` или `site.Params.env == "production"`.

Следствие: локальная сборка через `hugo server` может не содержать `application/ld+json` даже если схема “вроде есть” в теме.

### Важно: неверная семантика типов для страниц-списков

`schema_json.html` использует `@type: "BlogPosting"` для любых `.IsPage`.

У проекта есть страницы-линклисты (не статьи), и их логичнее размечать как `WebPage`/`CollectionPage` и, при желании, `ItemList`, а не `BlogPosting`.

### Конфиг: не хватает базовых `params` для качественной схемы

Файл: `hugo.yaml`

Замечания:
- Нет `params.description`, хотя шаблон схемы на главной использует `site.Params.description`.
- Нет `params.schema.*` (`publisherType`, `sameAs`), поэтому `sameAs` будет заполняться fallback-ом или окажется пустым/не тем.
- `baseURL: "/"` увеличивает шанс некорректных абсолютных URL в разметке, если на CI не задавать `--baseURL` (в репозитории есть `url.txt` с `https://brjed.netlify.app/`).

## План доработок (без внесения правок сейчас)

1. Добавить override `layouts/partials/templates/schema_json.html` (не менять submodule), чтобы генерировать валидный JSON-LD.
2. Генерацию полей сделать через `jsonify` или `printf "%q"` (строки/URL), даты форматировать в ISO-8601.
3. Пересмотреть типы:
- Home: `WebSite` + `Person`/`Organization`.
- Link-list страницы: `CollectionPage` и опционально `ItemList`.
- `BlogPosting` только для реальных постов/статей (если появятся).
4. В `hugo.yaml` добавить минимум метаданных для схемы:
- `params.description`
- `params.schema.publisherType` (`Person` или `Organization`)
- `params.schema.sameAs` (массив профилей)
- отдельный logo/image (не favicon), если важны rich results.
5. Проверять production-сборку через Schema.org Validator и Google Rich Results Test.

## Открытые вопросы

1. Сущность на главной: `Person` или `Organization`?
2. Цель: строго “валидная Schema.org семантика” или именно попытка получить Google rich results (breadcrumbs/person)?

## Версии/окружение

Субмодуль темы PaperMod: `v8.0-53-g1cf5327` (описание `git describe`).

Hugo:
- Netlify: `0.152.2` (`netlify.toml`)
- Локально: `0.155.2` (Homebrew)

