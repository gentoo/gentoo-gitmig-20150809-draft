# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/exonerate/exonerate-2.2.0.ebuild,v 1.1 2009/05/01 05:22:46 je_fro Exp $

EAPI="1"

DESCRIPTION="exonerate is a generic tool for pairwise sequence comparison"
HOMEPAGE="http://www.ebi.ac.uk/~guy/exonerate/"
SRC_URI="http://www.ebi.ac.uk/~guy/exonerate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="largefile utils"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_compile() {

	econf \
	$( use_enable largefile ) \
	$( use_enable utils utilities ) \
	--enable-glib2 \
	|| die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {

	emake DESTDIR="${D}" install || die "Install failed"
	doman doc/man/man1/*.1
	dodoc README
}
