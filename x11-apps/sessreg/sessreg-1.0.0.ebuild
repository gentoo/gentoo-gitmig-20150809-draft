# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/sessreg/sessreg-1.0.0.ebuild,v 1.4 2006/03/18 19:06:38 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org sessreg application"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"
