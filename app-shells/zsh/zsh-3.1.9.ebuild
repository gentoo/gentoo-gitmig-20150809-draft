# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-3.1.9.ebuild,v 1.4 2001/01/20 01:13:36 achim Exp $

P=zsh-3.1.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="UNIX Shell similar to the Korn shell"
SRC_URI="ftp://ftp.zsh.org/pub/"${A}
HOMEPAGE="www.zsh.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"

src_compile() {                           
	cd ${S}
	try ./configure --prefix=/ --mandir=/usr/man --infodir=/usr/info \
	    --libdir=/usr/lib --host=${CHOST}
	try make
}

src_install() {                               
	cd ${S}
	try make prefix=${D} mandir=${D}/usr/man infodir=${D}/usr/info \
		libdir=${D}/usr/lib \
		install.bin install.man install.modules
	prepman
	dodoc ChangeLog META-FAQ README
	docinto StartupFiles
 	dodoc StartupFiles/z*

}




