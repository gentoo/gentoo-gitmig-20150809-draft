# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <crux@gentoo.org>

P=puregui
S=${WORKDIR}/${P}
DESCRIPTION="A GUI to Configure Pure-FTPD"
SRC_URI="http://prdownloads.sourceforge.net/pureftpd/puregui.tar.gz"
HOMEPAGE="http://pureftpd.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-libs/gtk+-1.2.10"

src_compile() {

    cd ${S}
    try ./configure --cache-file=${FILESDIR}/config.cache --prefix=/usr --host=${CHOST} --mandir=/usr/share --infodir=/usr/share/info
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README

}
