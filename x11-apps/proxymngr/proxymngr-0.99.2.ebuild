# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/proxymngr/proxymngr-0.99.2.ebuild,v 1.1 2005/12/04 21:48:55 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org proxymngr application"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libICE
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproxymanagementprotocol"
