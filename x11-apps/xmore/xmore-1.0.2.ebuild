# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xmore/xmore-1.0.2.ebuild,v 1.1 2010/07/24 07:52:17 scarabeus Exp $

EAPI=3

XORG_STATIC=no
inherit xorg-2

DESCRIPTION="plain text display program for the X Window System"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="
	x11-libs/libXaw
	x11-libs/libXt
"
DEPEND="${RDEPEND}"
