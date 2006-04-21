# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xwd/xwd-1.0.1.ebuild,v 1.3 2006/04/21 21:00:44 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xwd application"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}"
