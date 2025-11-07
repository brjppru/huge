#!/bin/sh

exit 0

hugo new site brjed --format yaml
cd brjed
git init
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
git submodule update --init --recursive # needed when you reclone your repo (submodules may not get cloned automatically)

wget https://raw.githubusercontent.com/adityatelange/hugo-PaperMod/refs/heads/exampleSite/.gitignore

echo "theme: ["PaperMod"]" >> hugo.yaml
hugo server
