#!/bin/bash
find /usr/lib64 -name '*.la' | xargs sed -i -e '/^dep/s:-lpng12:-lpng14:'
find /usr/lib -name '*.la' | xargs sed -i -e '/^dep/s:-lpng12:-lpng14:'

# feel free to modify, licensed WTFPL-2
