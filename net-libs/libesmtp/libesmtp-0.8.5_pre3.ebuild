# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libesmtp/libesmtp-0.8.5_pre3.ebuild,v 1.1 2001/09/28 01:39:29 blocke Exp $

PKG=libesmtp-0.8.5pre3
A=${PKG}.tar.bz2
S=${WORKDIR}/${PKG}
DESCRIPTION="libESMTP is a library that implements the client side of the SMTP protocol"
SRC_URI="http://www.stafford.uklinux.net/libesmtp/${A}"
HOMEPAGE="http://www.stafford.uklinux.net/libesmtp/index.html"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST} --enable-require-all-recipients
    make || die

}

src_install () {

    try make prefix=${D}/usr install
	dodoc AUTHORS COPYING COPYING.GPL INSTALL ChangeLog NEWS Notes README TODO doc/api.xml

}

