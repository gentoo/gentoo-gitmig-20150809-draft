# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-2.2.3.ebuild,v 1.1 2011/02/03 17:08:52 weaver Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="Design primers for PCR reactions."
HOMEPAGE="http://primer3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	perl -i -ne 's/\$\(CPP\)/'$(tc-getCXX)'/; print unless /^(CC|CPP|CFLAGS|LDFLAGS)\s*=/' src/Makefile || die
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
