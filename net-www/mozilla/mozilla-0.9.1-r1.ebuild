# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.9.ebuild,v 1.4 2001/06/07 01:45:52 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.9.1-r1.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


A=mozilla-source-${PV}.tar.gz
S=${WORKDIR}/mozilla
DESCRIPTION=""
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/mozilla${PV}/src/${A}"
HOMEPAGE="http://www.mozilla.org"
PROVIDE="virtual/x11-web-browser"

DEPEND="sys-devel/perl >=gnome-base/ORBit-0.5.7
	>=x11-libs/gtk+-1.2.9
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip"
RDEPEND=">=gnome-base/ORBit-0.5.7
	>=x11-libs/gtk+-1.2.9
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip"

src_compile() {

    try ./configure --prefix=/opt/mozilla --host=${CHOST} \
	--with-gtk --disable-tests --disable-debug \
	--with-extensions=default,irc
    try make
    cd extensions/irc
    try make
    cd ../..
    try ./configure --prefix=/opt/mozilla --host=${CHOST} \
	--with-gtk --disable-tests --disable-debug \
	--with-extensions=default,irc
    try make BUILD_MODULES=psm

}

src_install () {

    dodir /opt/mozilla/include/nspr/{private,obsolete,md}
    cd dist/include
    cp -f *.h ${D}/opt/mozilla/include
    cp -f nspr/*.h ${D}/opt/mozilla/include/nspr
    cp -f nspr/obsolete/*.h ${D}/opt/mozilla/include/nspr/obsolete
    cp -f nspr/private/*.h ${D}/opt/mozilla/include/nspr/private
    cp -f nspr/md/*.cfg ${D}/opt/mozilla/include/nspr/md

    export MOZILLA_OFFICIAL=1
    export BUILD_OFFICIAL=1
    cd ${S}/xpinstall/packager
    try make
    dodir /opt
    tar xzf ${S}/dist/mozilla-`uname -m`-pc-linux-gnu.tar.gz -C ${D}/opt
    mv ${D}/opt/package ${D}/opt/mozilla

    exeinto /usr/bin
    doexe ${FILESDIR}/mozilla
    insinto /etc/env.d
    doins ${FILESDIR}/10mozilla
    dodoc LEGAL LICENSE README/mozilla/README*


}

