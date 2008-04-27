# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.11.0-r1.ebuild,v 1.6 2008/04/27 21:36:45 tupone Exp $

inherit eutils

DESCRIPTION="Cal3D is a skeletal based character animation library"
HOMEPAGE="http://home.gna.org/cal3d"
SRC_URI="http://download.gna.org/cal3d/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86 ~x86-fbsd"
IUSE="16bit-indices debug"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable 16bit-indices) \
		|| die
	emake || die
}

src_install() {
	einstall || die
}
