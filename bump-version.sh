#!/bin/bash

set -e

curl --silent "https://protonmail.com/download/current_version_linux.json" | jq -r ".Version" > VERSION
