# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xev/xev-1.0.2.ebuild,v 1.3 2006/06/30 16:45:00 wolf31o2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xev application"
KEYWORDS="amd64 ~arm ~mips ~ppc ppc64 ~s390 ~sparc x86"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
