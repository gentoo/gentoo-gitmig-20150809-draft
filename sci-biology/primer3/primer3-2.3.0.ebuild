# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-2.3.0.ebuild,v 1.2 2012/03/07 19:40:07 ranger Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="Primer Design for PCR reactions"
HOMEPAGE="http://primer3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~amd64 ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"

DEPEND="dev-lang/perl"
RDEPEND=""

src_prepare() {
	if [[ ${CHOST} == *-darwin* ]]; then
		sed -e "s:LIBOPTS ='-static':LIBOPTS =:" -i Makefile || die
	fi
	perl -i -ne 's/\$\(CPP\)/'$(tc-getCXX)'/; print unless /^(CC|CPP|CFLAGS|LDFLAGS)\s*=/' src/Makefile || die
	sed \
		-e '/oligotm/s:-o $@:$(LDFLAGS) -o $@:g' \
		-e '/long_seq_tm_test/s:-o $@:$(LDFLAGS) -o $@:g' \
		-e 's:CFLAGS:CXXFLAGS:g' \
		-i src/Makefile || die
}

src_compile() {
	emake -C src || die
}

src_test () {
	emake -C test || die
}

src_install () {
	dobin src/{long_seq_tm_test,ntdpal,oligotm,primer3_core} || die \
		"Could not install program."
	dodoc src/release_notes.txt example primer3_manual.htm || die \
		"Could not install documentation."
	insinto /opt/primer3_config
	doins -r src/primer3_config/* primer3*settings.txt || die
}
