# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/smproxy/smproxy-1.0.2.ebuild,v 1.1 2006/04/04 00:46:34 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org smproxy application"
KEYWORDS="~arm ~mips ~ppc64 ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXt
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
