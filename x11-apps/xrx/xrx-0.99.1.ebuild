# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xrx/xrx-0.99.1.ebuild,v 1.2 2005/10/27 03:43:45 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xrx application"
KEYWORDS="~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext"
DEPEND="${RDEPEND}"
IUSE="ipv6"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
