# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/lynx/lynx-2.8.3-r1.ebuild,v 1.5 2001/06/01 14:00:14 achim Exp $

# NOW HAS SSLeay Support (so it will use the SSLeay library if found to
# do SSL connections :)

P=lynx-2.8.3
A="lynx-2.8.3.tar.gz lynx-283-ssl.patch.gz"
S=${WORKDIR}/lynx-2.8.3.rel1
SRC_URI="ftp://lynx.isc.org/lynx-2.8.3/lynx-2.8.3.tar.gz
	 http://www.moxienet.com/lynx/lynx-283-ssl.patch.gz"

HOMEPAGE="http://lynx.browser.org/"

DESCRIPTION="An excellent console-based web browser"

DEPEND="virtual/glibc  nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.1
        >=sys-libs/zlib-1.1.3
	ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
        >=sys-libs/zlib-1.1.3
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_unpack() {
    unpack lynx-2.8.3.tar.gz
    cd ${S}
    if [ "`use ssl`" ] ; then
      gzip -dc ${DISTDIR}/lynx-283-ssl.patch.gz | patch -p1
    fi
    zcat ${O}/files/fr.po.gz > ${S}/po/fr.po
}

src_compile() {
    local myconf
    if [ "`use nls`" ] ; then
      myconf="--enable-nls"
    fi
    if [ "`use ssl`" ] ; then
      export CFLAGS="${CFLAGS} -I/usr/include/openssl"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --datadir=/usr/share \
        --libdir=/etc/lynx --enable-cgi-links \
	--enable-nsl-fork --libdir=/etc/lynx --enable-file-upload \
	--enable-libjs --enable-color-style --enable-scrollbar \
	--enable-included-msgs --with-zlib $myconf

    try make
}


src_install() {

    into /
    dodir /usr/bin
    dodir /usr/share
    dodir /etc/lynx
    try make prefix=${D}/usr datadir=${D}/usr/share \
        mandir=${D}/usr/share/man libdir=${D}/etc/lynx install


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





