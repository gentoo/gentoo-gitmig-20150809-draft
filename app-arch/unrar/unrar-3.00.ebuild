# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.00.ebuild,v 1.4 2002/07/17 20:44:57 drobbins Exp $

MY_P=${PN}src
S=${WORKDIR}
DESCRIPTION="Uncompress rar files"
SRC_URI="ftp://ftp.elf.stuba.sk/pub/pc/pack/${MY_P}.tgz"
SLOT="0"
HOMEPAGE="ftp://ftp.elf.stuba.sk/pub/pc/pack"
LICENSE="unRAR"

DEPEND="virtual/glibc
	app-arch/unzip"
RDEPEND="virtual/glibc"

src_compile() {

	make -f makefile.gcc || die
}

src_install() {
	dobin unrar
	dodoc readme.txt license.txt
}
