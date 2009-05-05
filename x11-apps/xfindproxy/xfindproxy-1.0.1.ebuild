# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xfindproxy/xfindproxy-1.0.1.ebuild,v 1.6 2009/05/05 07:53:45 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xfindproxy application"
KEYWORDS="~ppc ~ppc64 x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xproxymanagementprotocol"
