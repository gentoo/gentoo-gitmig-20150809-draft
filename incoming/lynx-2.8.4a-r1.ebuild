					# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Woodchip
# $Header: /var/cvsroot/gentoo-x86/incoming/lynx-2.8.4a-r1.ebuild,v 1.1 2001/08/22 11:44:52 danarmak Exp $

A="lynx2.8.4.tar.bz2 lynx2.8.4rel.1a.patch"
S=${WORKDIR}/lynx2-8-4
HOMEPAGE="http://lynx.browser.org/"
SRC_URI="ftp://lynx.isc.org/lynx/lynx2.8.4/lynx2.8.4.tar.bz2
                 ftp://lynx.isc.org/lynx/lynx2.8.4/patches/lynx2.8.4rel.1a.patch"

DESCRIPTION="An excellent console-based web browser"

DEPEND="virtual/glibc
                >=sys-libs/ncurses-5.1
                >=sys-libs/zlib-1.1.3

                nls? ( sys-devel/gettext )
                ssl? ( >= dev-libs/openssl-0.9.6 )"

src_unpack() {
        unpack lynx2.8.4.tar.bz2
        cd ${S}
        patch -p1 < ${DISTDIR}/lynx2.8.4rel.1a.patch || die
}

src_compile() {
        local myconf
        use nls && myconf="${myconf} --enable-nls"
        use ssl && myconf="${myconf} --with-ssl=/usr"
        use ipv6 && myconf="${myconf} --enable-ipv6"

        ./configure --prefix=/usr --mandir=/usr/share/man --datadir=/usr/share \
        --libdir=/etc/lynx --enable-cgi-links --enable-prettysrc \
        --enable-nsl-fork --enable-file-upload --enable-read-eta \
        --enable-libjs --enable-color-style --enable-scrollbar \
        --enable-included-msgs --with-zlib --host=${CHOST} ${myconf} || die

        emake || die
}

src_install() {
        make prefix=${D}/usr datadir=${D}/usr/share mandir=${D}/usr/share/man \
                libdir=${D}/etc/lynx install || die

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
