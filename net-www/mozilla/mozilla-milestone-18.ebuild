# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-milestone-18.ebuild,v 1.3 2000/12/03 23:12:28 drobbins Exp $

A=mozilla-source-M${PV}.tar.gz
S=${WORKDIR}/mozilla
DESCRIPTION=""
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/m${PV}/src/${A}"
HOMEPAGE="http://www.mozilla.org"
PROVIDE="virtual/x11-web-browser"

src_compile() {

    cd ${S}
    try CFLAGS=\"$CFLAGS -I/usr/lib/qt/include\" ./configure --prefix=/opt/mozilla --host=${CHOST} \
	--with-gtk	-enable-mathml --enable-svg 
    try make

}

src_install () {

    cd ${S}
    export MOZILLA_OFFICIAL=1
    export BUILD_OFFICIAL=1
    cd ${S}/xpinstall/packager
    try make
    dodir /opt
    tar xzf ${S}/dist/mozilla-i686-pc-linux-gnu.tar.gz -C ${D}/opt
    mv ${D}/opt/package ${D}/opt/mozilla
    dodoc LEGAL LICENSE README/mozilla/README*


}

