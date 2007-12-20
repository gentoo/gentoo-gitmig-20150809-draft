# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/lbxproxy/lbxproxy-1.0.1.ebuild,v 1.5 2007/12/19 23:50:56 cla Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Low BandWidth X proxy"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
RDEPEND="x11-libs/xtrans
	x11-libs/libXext
	x11-libs/liblbxutil
	x11-libs/libX11
	x11-libs/libICE"
DEPEND="${RDEPEND}
	x11-proto/xproxymanagementprotocol"
IUSE="ipv6"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
