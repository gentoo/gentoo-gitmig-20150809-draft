# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.0.2.ebuild,v 1.3 2001/08/11 09:27:09 hallski Exp $

#Note: ${A} is now auto-generated from SRC_URI; you shouldn't set it manually
#A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Clone of PICO with more Fuctions in a smaller Size"
#SRC_URI="http://www.nano-editor.org/dist/v1.0/${A}"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${P}.tar.gz"
HOMEPAGE="http://www.nano-editor.org"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/ncurses-5.2"

src_compile() {
    cd ${S}
#    try ./configure --prefix=/usr --enable-extra
#	FHS 2.2 compliance:
	try ./configure --prefix=/usr --enable-extra --mandir=/usr/share/man --infodir=/usr/share/info
	try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README 
}
