#!/bin/bash

set -e

if [[ $1 == "init" ]]
then
  gpg --generate-key --batch /protonmail/gpg-params &> /dev/null
  pass init "Proton Mail Bridge" &> /dev/null

  /protonmail/proton-bridge --cli 2> /dev/null
else
  socat TCP-LISTEN:2025,fork TCP:127.0.0.1:1025 &
  socat TCP-LISTEN:2143,fork TCP:127.0.0.1:1143 & 
  
  /protonmail/proton-bridge 2> /dev/null
fi
