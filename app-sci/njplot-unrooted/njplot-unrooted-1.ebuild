# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/njplot-unrooted/njplot-unrooted-1.ebuild,v 1.1 2004/10/06 12:44:33 ribosome Exp $

DESCRIPTION="A phylogenetic tree drawing program which supports tree rooting"
HOMEPAGE="http://pbil.univ-lyon1.fr/software/njplot.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-sci/ncbi-tools
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s%njplot.help%/usr/share/doc/${PF}/njplot.help%" njplot-vib.c
}

src_compile() {
	make -e || die
}

src_install() {
	dobin newicktops njplot unrooted

	insinto /usr/share/doc/${PF}
	doins njplot.help

	insinto /usr/share/${PN}
	doins test.ph
}
