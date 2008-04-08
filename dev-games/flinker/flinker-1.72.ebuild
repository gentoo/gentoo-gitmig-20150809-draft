# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/flinker/flinker-1.72.ebuild,v 1.6 2008/04/08 06:08:03 mr_bones_ Exp $

inherit toolchain-funcs

DESCRIPTION="GBA cart writing utility by Jeff Frohwein"
HOMEPAGE="http://www.devrs.com/gba/software.php#misc"
SRC_URI="http://www.devrs.com/gba/files/flgba.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/unistd/s:^//::' \
		-e 's:asm/io.h:sys/io.h:' \
		fl.c \
		|| die "sed failed"
	echo >> fl.c
	echo >> cartlib.c
}
src_compile() {
	$(tc-getCC) -o FLinker ${CFLAGS} fl.c || die
}

src_install() {
	dobin FLinker || die
	dodoc readme
}
