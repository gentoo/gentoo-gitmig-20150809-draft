# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xclipboard/xclipboard-1.1.1.ebuild,v 1.3 2010/12/23 11:01:52 ssuominen Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="interchange between cut buffer and selection"
KEYWORDS="amd64 ~arm ~hppa ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RDEPEND="x11-libs/libXaw
	x11-libs/libxkbfile
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}"
