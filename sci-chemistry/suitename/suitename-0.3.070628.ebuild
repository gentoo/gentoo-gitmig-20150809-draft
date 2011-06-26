# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/suitename/suitename-0.3.070628.ebuild,v 1.2 2011/06/26 09:10:34 jlec Exp $

EAPI=4

inherit toolchain-funcs

MY_P="${PN}.${PV}"

DESCRIPTION="The ROC RNA Ontology Consortium consensus RNA backbone nomenclature and conformer-list development"
HOMEPAGE="http://kinemage.biochem.duke.edu/software/suitename.php"
SRC_URI="http://kinemage.biochem.duke.edu/downloads/software/${PN}/${MY_P}.src.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="richardson"
IUSE=""

S="${WORKDIR}"/${MY_P}

src_prepare() {
	tc-export CC
	cp Makefile.linux Makefile || die
	sed \
		-e "s:-o:${LDFLAGS} -o:g" \
		-e 's:cc:${CC}:g' \
		-i Makefile || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ${PN}
}
