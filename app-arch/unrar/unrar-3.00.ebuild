# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.00.ebuild,v 1.1 2002/05/26 13:46:33 seemant Exp $

MY_P=${PN}src
S=${WORKDIR}
DESCRIPTION="Uncompress rar files"
SRC_URI="ftp://ftp.elf.stuba.sk/pub/pc/pack/${MY_P}.tgz"
HOMEPAGE="ftp://ftp.elf.stuba.sk/pub/pc/pack"

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
