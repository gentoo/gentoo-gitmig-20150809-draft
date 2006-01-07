# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/sessreg/sessreg-1.0.0.ebuild,v 1.2 2006/01/07 05:22:08 morfic Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org sessreg application"
KEYWORDS="~mips ~sparc ~x86 ~amd64"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"
