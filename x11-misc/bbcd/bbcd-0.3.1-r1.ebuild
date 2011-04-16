# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbcd/bbcd-0.3.1-r1.ebuild,v 1.10 2011/04/16 17:23:21 ulm Exp $

inherit eutils

DESCRIPTION="Basic CD Player for blackbox wm"
HOMEPAGE="http://tranber1.free.fr/bbcd.html"
SRC_URI="http://tranber1.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libcdaudio"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}_${PV}a.diff
	epatch "${FILESDIR}"/${P}-gcc3.3.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_install () {
	make \
		DESTDIR="${D}" \
		install || die
	rm -rf "${D}"/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
