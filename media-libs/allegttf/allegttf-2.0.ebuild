# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegttf/allegttf-2.0.ebuild,v 1.4 2003/09/11 01:17:46 msterret Exp $

DESCRIPTION="Anti-aliased text output and font loading routines for Allegro"
HOMEPAGE="http://huizen.dds.nl/~deleveld/allegttf.htm"
SRC_URI="http://huizen.dds.nl/~deleveld/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=media-libs/allegro-4.0.0"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}"

src_compile() {
	emake || die
	emake examples || die
}

src_install() {
	dodir /usr/include
	dodir /usr/lib

	cd ${S}/source
	mv makefile.lnx makefile.lnx_orig
	# hardcoded install paths in makefile
	sed s/'\/usr\/local'/'${D}\/usr'/ makefile.lnx_orig > makefile.lnx

	cd ${S}
	dodoc docs/*.txt *.txt
	dohtml docs/allegttf.htm

	insinto /usr/share/doc/${P}/examples
	doins examples/*

	make install || die
}
