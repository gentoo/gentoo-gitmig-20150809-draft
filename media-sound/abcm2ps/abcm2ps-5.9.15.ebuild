# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-5.9.15.ebuild,v 1.5 2011/12/18 17:49:39 armin76 Exp $

EAPI=2

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://moinejf.free.fr/${P}.tar.gz
	http://moinejf.free.fr/transpose_abc.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	sed -i \
		-e '/LDFLAGS/s:=.*:= @LDFLAGS@:' \
		Makefile.in || die
}

src_configure() {
	econf \
		--enable-a4 \
		--enable-deco-is-roll
}

src_install() {
	dobin abcm2ps || die

	insinto /usr/share/${PN}
	doins *.fmt || die

	dodoc Changes README *.txt || die

	insinto /usr/share/doc/${PF}/examples
	doins *.{abc,eps} || die

	insinto /usr/share/doc/${PF}/contrib
	doins "${DISTDIR}"/transpose_abc.pl || die
}
