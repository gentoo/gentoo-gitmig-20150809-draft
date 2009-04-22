# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/listres/listres-1.0.1-r1.ebuild,v 1.8 2009/04/22 00:39:42 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="list resources in widgets"
KEYWORDS="amd64 arm ~hppa ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXaw"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--disable-xprint"
