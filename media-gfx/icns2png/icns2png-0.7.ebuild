# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icns2png/icns2png-0.7.ebuild,v 1.1 2008/04/19 12:28:00 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Converts Mac OSX .icns files to .png files"
HOMEPAGE="http://www.eisbox.net/dev/icns2png"
SRC_URI="http://www.eisbox.net/software/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" install || die "emake install failed."
	dodoc AUTHORS README
}

src_test() {
	emake test || die "emake test failed."
}
