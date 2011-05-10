# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20100311.ebuild,v 1.2 2011/05/10 10:20:54 xmw Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator."
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/${P}.tar.gz"

DEPEND="|| ( >=dev-util/cweb-3.63 virtual/tex-base )"
RDEPEND=""

SLOT="0"
LICENSE="mmix"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

S="${WORKDIR}"

src_prepare() {
cp -av Makefile{,.orig}
	epatch \
		"${FILESDIR}"/${PN}-20060324-makefile.patch
}

src_compile() {
	emake all \
		CFLAGS="${CFLAGS}" \
		CC=$(tc-getCC) \
		|| die
	if use doc ; then
		emake doc || die
	fi
}

src_install () {
	dobin mmix mmixal mmmix mmotype abstime
	dodoc README mmix.1
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins *.ps
	fi
}
