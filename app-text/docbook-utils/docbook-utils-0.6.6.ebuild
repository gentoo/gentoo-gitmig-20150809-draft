# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-utils/docbook-utils-0.6.6.ebuild,v 1.1 2001/03/06 06:20:41 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Shell scripts to manage DocBook documents"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${A}
	 http://download.sourceforge.net/pub/mirrors/kde/devel/docbook/SOURCES/${A}"
HOMEPAGE="http://"

DEPEND=">=sys-apps/bash-2.04
	>=sys-devel/perl-5"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
    mv ${D}/usr/share/doc/html/${P} ${D}/usr/doc/${P}/html
    rm -r ${D}/usr/share/doc
}

