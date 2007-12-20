# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fstobdf/fstobdf-1.0.2.ebuild,v 1.4 2007/12/19 23:49:13 cla Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="generate BDF font from X font server"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
RDEPEND="x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}"
