# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/rnaview/rnaview-20040713-r1.ebuild,v 1.1 2008/08/26 18:08:55 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Generates 2D displays of RNA/DNA secondary structures with tertiary interactions"
HOMEPAGE="http://ndbserver.rutgers.edu/services/download/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s/CC        = cc/CC        = $(tc-getCC)/" \
		-e "s/CFLAGS  =/CFLAGS  = ${CFLAGS}/" \
		-i Makefile || die
}

src_compile() {
	make clean
	make || die "Failed to build programs."
	cd "${S}"/rnaml2ps
	make clean
	make || die "Failed to build rnaml2ps."
	cd "${S}"/test
	rm '.#t'
}

src_install() {
	dobin bin/rnaview rnaml2ps/rnaml2ps || die "Failed to install programs."
	dodoc README || die "Failed to install documentation."
	mkdir -p "${D}"/usr/share/${PN}
	cp -r BASEPARS test "${D}"/usr/share/${PN}
	cat <<- EOF > 22rnaview
		RNAVIEW="/usr/share/rnaview"
	EOF
	doenvd 22rnaview || die "Failed to install environment file."
}
