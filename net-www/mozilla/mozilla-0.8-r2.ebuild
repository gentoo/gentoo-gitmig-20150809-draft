# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.8-r2.ebuild,v 1.1 2001/03/07 11:10:33 achim Exp $

A=mozilla-source-${PV}.tar.gz
S=${WORKDIR}/mozilla
DESCRIPTION=""
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/mozilla${PV}/src/${A}"
HOMEPAGE="http://www.mozilla.org"
PROVIDE="virtual/x11-web-browser"

DEPEND=">=gnome-base/ORBit-0.5.7
	>=x11-libs/gtk+-1.2.9
	>=sys-libs/zlib-1.1.3
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9"

src_compile() {

    try ./configure --prefix=/opt/mozilla --host=${CHOST} \
	--with-gtk --disable-tests --disable-debug --enable-cpp-rtti \
	--enable-optimize --disable-mailnews
    try make

}

src_install () {

    export MOZILLA_OFFICIAL=1
    export BUILD_OFFICIAL=1
    cd ${S}/xpinstall/packager
    try make
    dodir /opt
    tar xzf ${S}/dist/mozilla-i686-pc-linux-gnu.tar.gz -C ${D}/opt
    mv ${D}/opt/package ${D}/opt/mozilla
    dodir /opt/mozilla/include/{private,obsolete}
    cp ${S}/dist/include/*.h ${D}/opt/mozilla/include
    cp ${S}/dist/include/obsolete/*.h ${D}/opt/mozilla/include/obsolete
    cp ${S}/dist/include/private/*.h ${D}/opt/mozilla/include/private
    exeinto /usr/bin
    doexe ${FILESDIR}/mozilla
    dodoc LEGAL LICENSE README/mozilla/README*


}

