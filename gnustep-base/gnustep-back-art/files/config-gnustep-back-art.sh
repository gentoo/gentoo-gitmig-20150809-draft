#!/bin/bash

echo "Switching to libgnustep-art backend ..."
echo "defaults write NSGlobalDomain GSBackend libgnustep-art"
defaults write NSGlobalDomain GSBackend libgnustep-art

echo "Setting default fonts..."
defaults write NSGlobalDomain NSFont BitstreamVeraSans-Roman
defaults write NSGlobalDomain NSBoldFont BitstreamVeraSans-Bold
defaults write NSGlobalDomain NSUserFixedPitchFont BitstreamVeraSansMono-Roman

