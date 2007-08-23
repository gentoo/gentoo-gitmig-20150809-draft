# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/stripclub/stripclub-0.9.1.2.ebuild,v 1.7 2007/08/23 17:56:30 jer Exp $

inherit eutils

MY_P="${PN}_${PV}"

DESCRIPTION="A webcomic reader."
HOMEPAGE="http://stripclub.sourceforge.net/"
SRC_URI="mirror://sourceforge/stripclub/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc x86"
IUSE=""

DEPEND=">=x11-libs/fltk-1.1.4
		>=dev-libs/libpcre-5.0
		>=media-libs/libpng-1.2.8
		>=media-libs/jpeg-6b-r4
		x11-libs/libXpm"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-Makefile.linux.patch
}

src_compile() {
	./configure --skip-tests
	emake PREFIX=/usr || die "emake failed"
}

src_install() {
	make \
		PREFIX=${D}/usr \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${P} \
		install || die
}
