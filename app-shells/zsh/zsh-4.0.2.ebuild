# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# This ebuild by Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.0.2.ebuild,v 1.1 2001/07/03 12:19:26 pm Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="UNIX Shell similar to the Korn shell"
SRC_URI="ftp://ftp.zsh.org/pub/${A}"
HOMEPAGE="www.zsh.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1"

src_compile() {

    try ./configure --prefix=/ --mandir=/usr/share/man \
	    --libdir=/usr/lib --host=${CHOST}
	try make
}

src_install() {

	try make prefix=${D} mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib \
		install.bin install.man install.modules

	dodoc ChangeLog META-FAQ README
	docinto StartupFiles
 	dodoc StartupFiles/z*

}




