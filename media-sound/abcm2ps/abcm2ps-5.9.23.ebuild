# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-5.9.23.ebuild,v 1.1 2011/06/25 23:36:55 radhermit Exp $

EAPI=4

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://moinejf.free.fr/${P}.tar.gz
	http://moinejf.free.fr/transpose_abc.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

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
	dobin abcm2ps

	insinto /usr/share/${PN}
	doins *.fmt

	dodoc Changes README *.txt

	insinto /usr/share/doc/${PF}/examples
	doins *.{abc,eps}

	insinto /usr/share/doc/${PF}/contrib
	doins "${DISTDIR}"/transpose_abc.pl
}
