# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegttf/allegttf-2.0.ebuild,v 1.7 2004/10/31 21:52:02 josejx Exp $

DESCRIPTION="Anti-aliased text output and font loading routines for Allegro"
HOMEPAGE="http://huizen.dds.nl/~deleveld/allegttf.htm"
SRC_URI="http://huizen.dds.nl/~deleveld/${P}.tar.gz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=media-libs/allegro-4.0.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i \
		-e 's/make/$(MAKE)/' ${S}/Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
	emake examples || die "emake failed (examples)"
}

src_install() {
	cd ${S}/source
	# hardcoded install paths in makefile
	sed -i \
		-e s/'\/usr\/local'/'${D}\/usr'/ makefile.lnx \
			|| die "sed failed"

	cd ${S}
	dodir /usr/include
	dodir /usr/lib
	make install || die "make install failed"
	dodoc docs/*.txt *.txt || die "dodoc failed"
	dohtml docs/allegttf.htm || die "dohtml failed"
	insinto /usr/share/doc/${P}/examples
	doins examples/* || die "doins failed"
}
