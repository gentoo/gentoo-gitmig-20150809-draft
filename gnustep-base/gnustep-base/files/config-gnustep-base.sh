#!/bin/bash
#
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-base/files/config-gnustep-base.sh,v 1.1 2004/09/24 01:04:11 fafhrd Exp $

TIME_ZONE="America/New_York"
LANGUAGE="English"

echo "defaults write NSGlobalDomain \"Local Time Zone\" ${TIME_ZONE}"
defaults write NSGlobalDomain "Local Time Zone" ${TIME_ZONE}
echo "defaults write NSGlobalDomain NSLanguages \"(${LANGUAGE})\""
defaults write NSGlobalDomain NSLanguages "(${LANGUAGE})"

