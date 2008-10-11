# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xmore/xmore-1.0.1-r1.ebuild,v 1.2 2008/10/11 22:28:08 flameeyes Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="plain text display program for the X Window System"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
# Broken without xprint
IUSE="xprint"
RDEPEND="xprint? ( x11-libs/libXprintUtil )
	x11-libs/libXaw"
#x11-libs/libXprintUtil"
DEPEND="${RDEPEND}"
PATCHES="${FILESDIR}/${P}-ifdef-xprint.patch"
CONFIGURE_OPTIONS="$(use_enable xprint)"
