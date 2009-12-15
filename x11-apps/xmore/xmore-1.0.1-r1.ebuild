# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xmore/xmore-1.0.1-r1.ebuild,v 1.5 2009/12/15 19:18:50 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="plain text display program for the X Window System"
KEYWORDS="amd64 arm ~mips ~ppc ppc64 s390 sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}"
PATCHES=( ${FILESDIR}/${P}-ifdef-xprint.patch )
CONFIGURE_OPTIONS="--disable-xprint"
