#!/bin/bash

set -e

VERSION=$(cat VERSION)

git clone https://github.com/ProtonMail/proton-bridge.git
cd proton-bridge
git checkout v$VERSION

make build-nogui
