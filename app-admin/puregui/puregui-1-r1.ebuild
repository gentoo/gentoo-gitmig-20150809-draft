# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/puregui/puregui-1-r1.ebuild,v 1.6 2002/07/17 20:43:17 drobbins Exp $



P=puregui
S=${WORKDIR}/${P}
DESCRIPTION="A GUI to Configure Pure-FTPD"
SRC_URI="mirror://sourceforge/pureftpd/puregui.tar.gz"
SLOT="0"
HOMEPAGE="http://pureftpd.sourceforge.net"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*"

src_compile() {

    try ./configure --cache-file=${FILESDIR}/config.cache --prefix=/usr --host=${CHOST} --mandir=/usr/share --infodir=/usr/share/info
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README

}
