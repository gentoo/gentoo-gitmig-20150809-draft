#!/bin/bash

# Bitstream Vera is known to work well on display for GNUstep

FONT="BitstreamVeraSans-Roman"
BOLD="BitstreamVeraSans-Bold"
FIXED="BitstreamVeraSansMono-Roman"
#FONT="FreeSans"
#BOLD="FreeSansBold"
#FIXED="FreeMono"

echo "defaults write NSGlobalDomain NSFont ${FONT}"
defaults write NSGlobalDomain NSFont ${FONT}
echo "defaults write NSGlobalDomain NSBoldFont ${BOLD}"
defaults write NSGlobalDomain NSBoldFont ${BOLD}
echo "defaults write NSGlobalDomain NSUserFixedPitchFont ${FIXED}"
defaults write NSGlobalDomain NSUserFixedPitchFont ${FIXED}

