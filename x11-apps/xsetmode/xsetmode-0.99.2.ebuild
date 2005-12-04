# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetmode/xsetmode-0.99.2.ebuild,v 1.1 2005/12/04 22:19:21 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xsetmode application"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXi
	x11-libs/libX11"
DEPEND="${RDEPEND}"
