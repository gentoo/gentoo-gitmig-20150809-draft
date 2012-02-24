# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xclipboard/xclipboard-1.1.2.ebuild,v 1.1 2012/02/24 15:35:47 chithanh Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="interchange between cut buffer and selection"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RDEPEND="x11-libs/libXaw
	x11-libs/libxkbfile
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}"
