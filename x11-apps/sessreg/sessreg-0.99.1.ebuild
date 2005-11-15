# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/sessreg/sessreg-0.99.1.ebuild,v 1.2 2005/11/15 13:40:49 geoman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org sessreg application"
KEYWORDS="~mips ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"
