# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXft/libXft-2.1.7.ebuild,v 1.3 2005/08/13 05:35:01 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xft library"
KEYWORDS="~sparc ~x86"
RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	media-libs/freetype
	>=media-libs/fontconfig-2.2"
DEPEND="${RDEPEND}"

PROVIDE="virtual/xft"
