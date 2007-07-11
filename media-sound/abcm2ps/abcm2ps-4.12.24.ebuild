# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-4.12.24.ebuild,v 1.2 2007/07/11 19:30:23 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://moinejf.free.fr/${P}.tar.gz
	http://moinejf.free.fr/transpose_abc.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"

DEPEND=""

src_compile() {
	# a4: A4 format instead of US letter
	# deco-is-roll: ~ as roll instead of twiddle (generate 2 files)
	# clef-transpose: have clef changing the note pitch
	econf \
	--with-a4 \
	--with-deco-is-roll \
	--with-clef-transpose \
	|| die "Configure failed"
	emake
}

src_install() {
	dodoc README INSTALL *.txt Changes
	dobin abcm2ps
	insinto /usr/share/${PN}
	doins *.fmt
	insinto /usr/share/doc/${P}/examples
	doins *.abc *.eps
	insinto /usr/share/doc/${P}/contrib
	doins ${DISTDIR}/transpose_abc.pl
}
