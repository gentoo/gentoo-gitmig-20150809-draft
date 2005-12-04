# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbprint/xkbprint-0.99.2.ebuild,v 1.1 2005/12/04 22:08:12 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xkbprint application"
KEYWORDS="~amd64 ~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libxkbfile"
DEPEND="${RDEPEND}"
