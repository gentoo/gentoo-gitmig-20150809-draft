# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/editres/editres-1.0.3-r1.ebuild,v 1.1 2009/01/14 13:55:26 remi Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="a dynamic resource editor for X Toolkit applications"

KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="xprint"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXaw"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--disable-xprint"
