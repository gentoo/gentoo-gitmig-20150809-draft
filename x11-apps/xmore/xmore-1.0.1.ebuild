# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xmore/xmore-1.0.1.ebuild,v 1.5 2007/12/20 00:18:53 cla Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="plain text display program for the X Window System"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
# Broken without xprint
IUSE="xprint"
RDEPEND="xprint? ( x11-libs/libXprintUtil )"
#x11-libs/libXprintUtil"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable xprint)"
