# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-utils/docbook-sgml-utils-0.6.6.ebuild,v 1.1 2001/03/20 05:47:31 achim Exp $

A=docbook-utils-${PV}.tar.gz
S=${WORKDIR}/docbook-utils-${PV}
DESCRIPTION="Shell scripts to manage DocBook documents"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${A}
	 http://download.sourceforge.net/pub/mirrors/kde/devel/docbook/SOURCES/${A}"
HOMEPAGE="http://"

DEPEND=">=sys-devel/perl-5"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr mandir=${D}/usr/share/man install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
    mv ${D}/usr/doc/html/docbook-utils-${PV} ${D}/usr/share/doc/${P}/html
    rm -r ${D}/usr/doc/
}

