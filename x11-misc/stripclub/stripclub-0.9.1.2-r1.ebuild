# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/stripclub/stripclub-0.9.1.2-r1.ebuild,v 1.1 2007/12/01 20:57:19 coldwind Exp $

inherit eutils

MY_P="${PN}_${PV}"

DESCRIPTION="A webcomic reader."
HOMEPAGE="http://stripclub.sourceforge.net/"
SRC_URI="mirror://sourceforge/stripclub/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/fltk-1.1.4
		>=dev-libs/libpcre-5.0
		>=media-libs/libpng-1.2.8
		>=media-libs/jpeg-6b-r4
		x11-libs/libXpm"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile-fixes.patch
}

src_compile() {
	# No standard configure script.
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PN} \
		--skip-tests || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
