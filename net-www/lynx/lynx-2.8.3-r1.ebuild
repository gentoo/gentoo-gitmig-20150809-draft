# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/lynx/lynx-2.8.3-r1.ebuild,v 1.2 2000/08/16 04:38:21 drobbins Exp $

# NOW HAS SSLeay Support (so it will use the SSLeay library if found to
# do SSL connections :)

P=lynx-2.8.3
A="lynx-2.8.3.tar.gz lynx-283-ssl.patch.gz"
S=${WORKDIR}/lynx-2.8.3.rel1
SRC_URI="ftp://lynx.isc.org/lynx-2.8.3/lynx-2.8.3.tar.gz
	 http://www.moxienet.com/lynx/lynx-283-ssl.patch.gz"

HOMEPAGE="http://lynx.browser.org/"

DESCRIPTION="An excellent console-based web browser"

src_compile() {                           
    export CFLAGS="${CFLAGS} -I/usr/include/openssl"
    ./configure --prefix=/usr --enable-cgi-links \
	--enable-nsl-fork --libdir=/etc/lynx --enable-file-upload \
	--enable-libjs --enable-color-style --enable-scrollbar \
	--enable-nls --with-catgets --enable-included-msgs --with-zlib \
	--with-x
    make
}

src_unpack() {
    unpack lynx-2.8.3.tar.gz
    cd ${S}
    gzip -dc ${DISTDIR}/lynx-283-ssl.patch.gz | patch -p1
    zcat ${O}/files/fr.po.gz > ${S}/po/fr.po
}

src_install() {                               
    cd ${S}
    into /
    dodir /usr/bin
    dodir /usr/share
    dodir /etc/lynx
    make prefix=${D}/usr datadir=${D}/usr/share libdir=${D}/etc/lynx install
    prepman

    dodoc CHANGES COPYHEADER COPYING INSTALLATION PROBLEMS README
    docinto docs
    dodoc docs/* 
    docinto lynx_help
    dodoc lynx_help/*.txt
    docinto html
    dodoc lynx_help/*.html
    docinto html/keystrokes
    dodoc lynx_help/keystrokes/*.html
}





