# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/njplot/njplot-20050109.ebuild,v 1.5 2007/07/22 07:30:55 dberkholz Exp $

DESCRIPTION="A phylogenetic tree drawing program which supports tree rooting"
HOMEPAGE="http://pbil.univ-lyon1.fr/software/njplot.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/libXmu"

DEPEND="sci-biology/ncbi-tools
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s%njplot.help%/usr/share/doc/${PF}/njplot.help%" njplot-vib.c || die
}

src_compile() {
	make all -e || die
}

src_install() {
	dobin add_root newicktops newicktotxt njplot unrooted
	insinto /usr/share/doc/${PF}
	doins njplot.help
	insinto /usr/share/${PN}
	doins test.ph
}
