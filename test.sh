#!/bin/bash

distro_ver="$(cat /etc/fedora-release | tr -dc '0-9.' | cut -d \. -f1).$(cat /etc/fedora-release | tr -dc '0-9.' | cut -d \. -f2)"


echo -e "var1\n=$distro_ver"
