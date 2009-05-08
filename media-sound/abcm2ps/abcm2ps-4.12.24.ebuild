# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-4.12.24.ebuild,v 1.3 2009/05/08 18:45:29 gentoofan23 Exp $

inherit eutils

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://moinejf.free.fr/${P}.tar.gz
	http://moinejf.free.fr/transpose_abc.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_compile() {
	# a4: A4 format instead of US letter
	# deco-is-roll: ~ as roll instead of twiddle (generate 2 files)
	# clef-transpose: have clef changing the note pitch
	econf \
	--with-a4 \
	--with-deco-is-roll \
	--with-clef-transpose
	emake || die "Emake failed!"
}

src_install() {
	dodoc README *.txt Changes || die "Dodoc failed!"
	dobin abcm2ps || die "Dobin failed"
	insinto /usr/share/${PN}
	doins *.fmt || die "Doins *.fmt failed!"
	insinto /usr/share/doc/${P}/examples
	doins *.abc *.eps || die "Doins *.abc *.eps failed!"
	insinto /usr/share/doc/${P}/contrib
	doins "${DISTDIR}"/transpose_abc.pl || die "Doins transpose_abc.pl failed!"
}
