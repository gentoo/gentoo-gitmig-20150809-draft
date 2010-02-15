# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbiff/xbiff-1.0.2.ebuild,v 1.5 2010/02/15 19:12:47 josejx Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="mailbox flag for X"

KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-misc/xbitmaps
	x11-libs/libXext"
DEPEND="${RDEPEND}"
