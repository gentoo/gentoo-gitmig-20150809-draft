# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/lbxproxy/lbxproxy-0.99.2.ebuild,v 1.1 2005/11/11 19:49:16 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org lbxproxy application"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/xtrans
	x11-libs/libXext
	x11-libs/liblbxutil
	x11-libs/libX11
	x11-libs/libICE"
DEPEND="${RDEPEND}
	x11-proto/xproxymanagementprotocol"
IUSE="ipv6"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
