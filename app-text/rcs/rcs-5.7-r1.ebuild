# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/rcs/rcs-5.7-r1.ebuild,v 1.3 2001/11/24 18:40:50 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Revision Controll System"
SRC_URI="ftp://ftp.gnu.org/gnu/rcs/${A}"
HOMEPAGE="http://www.gnu.org/software/rcs/"

EPEND="virtual/glibc"

REPEND="virtual/glibc
	sys-apps/diffutils"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --with-diffutils
    cp ${FILESDIR}/conf.sh src/conf.sh
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr \
	man1dir=${D}/usr/share/man/man1 \
	man3dir=${D}/usr/share/man/man3 \
	man5dir=${D}/usr/share/man/man5 install
    dodoc ChangeLog COPYING CREDITS NEWS README REFS
}

