# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbevd/xkbevd-1.0.2.ebuild,v 1.4 2007/12/20 00:14:28 cla Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="XKB event daemon"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
RDEPEND="x11-libs/libxkbfile"
DEPEND="${RDEPEND}"
