# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xman/xman-1.0.2-r1.ebuild,v 1.9 2009/04/22 00:45:48 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Manual page display program for the X Window System"

KEYWORDS="amd64 arm ~hppa ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--disable-xprint"
