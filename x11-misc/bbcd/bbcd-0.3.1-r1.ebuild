# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbcd/bbcd-0.3.1-r1.ebuild,v 1.8 2006/12/07 02:21:22 flameeyes Exp $

inherit eutils

DESCRIPTION="Basic CD Player for blackbox wm"
HOMEPAGE="http://tranber1.free.fr/bbcd.html"
SRC_URI="http://tranber1.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/blackbox
		media-libs/libcdaudio"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}_${PV}a.diff
	epatch "${FILESDIR}"/${P}-gcc3.3.patch
}

src_install () {
	make \
		DESTDIR="${D}" \
		install || die
	rm -rf "${D}"/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
