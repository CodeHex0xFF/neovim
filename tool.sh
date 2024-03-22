#!/bin/bash

cat <<-EOF | tee .gitconfig
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true    # use n and N to move between diff sections

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
EOF

cargo install git-delta  du-dust fd-find rigrep
git clone https://github.com/muesli/duf.git
cd duf
go build
cd -

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

git clone https://github.com/cantino/mcfly
cd mcfly
cargo install --path .
cd -

wget https://github.com/sharkdp/hyperfine/releases/download/v1.16.1/hyperfine_1.16.1_amd64.deb
sudo dpkg -i hyperfine_1.16.1_amd64.deb

curl -sfL https://raw.githubusercontent.com/ducaale/xh/master/install.sh | sh

cargo instal procs
sudo apt instal btop
cargo install --git https://github.com/kamiyaa/joshuto.git --force
sudo apt install bsdtar
cargo install termscp
