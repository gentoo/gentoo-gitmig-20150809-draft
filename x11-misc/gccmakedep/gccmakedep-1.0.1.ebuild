# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gccmakedep/gccmakedep-1.0.1.ebuild,v 1.2 2005/12/27 23:29:57 stefaan Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org gccmakedep utility"
KEYWORDS="~alpha ~amd64 ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xproto"
