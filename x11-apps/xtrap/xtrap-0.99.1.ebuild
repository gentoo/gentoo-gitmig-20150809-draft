# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xtrap/xtrap-0.99.1.ebuild,v 1.1 2005/10/20 00:45:25 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xtrap application"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXTrap"
DEPEND="${RDEPEND}"
