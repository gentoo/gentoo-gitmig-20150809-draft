# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xset/xset-0.99.4.ebuild,v 1.1 2005/12/04 22:20:53 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xset application"
KEYWORDS="~amd64 ~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXmu"
DEPEND="${RDEPEND}"
