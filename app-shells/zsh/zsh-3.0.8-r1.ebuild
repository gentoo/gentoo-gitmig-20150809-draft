# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-3.0.8-r1.ebuild,v 1.2 2000/08/16 04:37:54 drobbins Exp $

P=zsh-3.0.8      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="UNIX Shell similar to the Korn shell"
SRC_URI="ftp://ftp.zsh.org/pub/"${A}
HOMEPAGE="www.zsh.org/"

src_compile() {                           
	cd ${S}
	./configure --prefix=/ --mandir=/usr/man --infodir=/usr/info --host=${CHOST}
	make
}

src_install() {                               
	cd ${S}
	make prefix=${D} mandir=${D}/usr/man infodir=${D}/usr/info install.bin install.man
	prepman
	dodoc ChangeLog META-FAQ README
	docinto StartupFiles
 	dodoc StartupFiles/z*

}




