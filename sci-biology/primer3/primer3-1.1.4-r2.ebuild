# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-1.1.4-r2.ebuild,v 1.2 2011/11/23 08:10:50 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Primer Design for PCR reactions"
HOMEPAGE="http://primer3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="whitehead"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"

DEPEND="dev-lang/perl"
RDEPEND=""

S=${WORKDIR}/src

src_prepare() {

	[[ ${CHOST} == *-darwin* ]] && \
		sed -e "s:LIBOPTS ='-static':LIBOPTS =:" -i Makefile
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake -e CC="$(tc-getCC)" || die
}

src_test () {
	emake primer_test || die
}

src_install () {
	dobin long_seq_tm_test ntdpal oligotm primer3_core || die
	dodoc ../{how-to-cite.txt,README.txt,example} || die
}
