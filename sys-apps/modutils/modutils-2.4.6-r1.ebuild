# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.6-r1.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Standard kernel module utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4/${A}"

DEPEND="virtual/glibc"

src_compile() {
	try ./configure --prefix=/ --mandir=/usr/share/man --host=${CHOST} --disable-strip
	try make ${MAKEOPTS}
}

src_install() {
	try make prefix=${D} mandir=${D}/usr/share/man install
	if [ -z "`use bootcd`" ]
	then
		dodoc COPYING CREDITS ChangeLog NEWS README TODO
	else
		rm -rf ${D}/usr
	fi

}
