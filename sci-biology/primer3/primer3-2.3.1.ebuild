# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-2.3.1.ebuild,v 1.1 2012/07/19 12:21:52 jlec Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Primer Design for PCR reactions"
HOMEPAGE="http://primer3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"

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
	emake -C src
}

src_test () {
	emake -C test
}

src_install () {
	dobin src/{long_seq_tm_test,ntdpal,oligotm,primer3_core}
	dodoc src/release_notes.txt example
	insinto /opt/primer3_config
	doins -r src/primer3_config/* primer3*settings.txt
	dohtml primer3_manual.htm
}
