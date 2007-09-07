# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbacklight/xbacklight-1.1.ebuild,v 1.2 2007/09/07 19:34:59 wolf31o2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Sets backlight level using the RandR 1.2 BACKLIGHT output property"
KEYWORDS="x86"
RDEPEND=">=x11-libs/libXrandr-1.2"
DEPEND="${RDEPEND}"
