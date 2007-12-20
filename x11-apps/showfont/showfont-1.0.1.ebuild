# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/showfont/showfont-1.0.1.ebuild,v 1.5 2007/12/19 23:56:21 cla Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="font dumper for X font server"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
RDEPEND="x11-libs/libFS"
DEPEND="${RDEPEND}"
