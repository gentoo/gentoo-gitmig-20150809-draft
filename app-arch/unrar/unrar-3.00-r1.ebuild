# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.00-r1.ebuild,v 1.11 2003/02/13 05:57:15 vapier Exp $

MY_P=${PN}src
S=${WORKDIR}
DESCRIPTION="Uncompress rar files"
SRC_URI="ftp://ftp.elf.stuba.sk/pub/pc/pack/${MY_P}.tgz"
HOMEPAGE="ftp://ftp.elf.stuba.sk/pub/pc/pack"

SLOT="0"
LICENSE="unRAR"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="app-arch/unzip"

src_compile() {
	cp ${FILESDIR}/unrar-3.00-rartypes.hpp rartypes.hpp
	make -f makefile.gcc || die
}

src_install() {
	dobin unrar
	dodoc readme.txt license.txt
}
