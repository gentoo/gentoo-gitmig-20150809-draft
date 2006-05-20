# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xcmsdb/xcmsdb-1.0.1.ebuild,v 1.3 2006/05/20 10:44:58 robbat2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xcmsdb application"
KEYWORDS="~arm ~mips ~ppc64 ~s390 ~sparc ~x86 ~ppc"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
