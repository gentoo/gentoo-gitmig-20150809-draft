# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.5.6_beta.ebuild,v 1.3 2001/08/27 00:11:57 drobbins Exp $

P=${PN}-v3.5.6-beta
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libtiff"
SRC_URI="http://www.libtiff.org/"${A}
HOMEPAGE="http://www.libtiff.org/"

DEPEND=">=media-libs/jpeg-6b >=sys-libs/zlib-1.1.3-r2"

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${FILESDIR}/config.site-${PV} config.site
    echo "DIR_HTML="${D}/usr/share/doc/${PF}/html"" >> config.site
#    mv configure configure.orig
#    sed -e "s:if \[ -r /lib/libc.*:if \[ -r /lib/libc\.so\.6 \]\; then:" \
#	configure.orig > configure
#    chmod +x configure
}

src_compile() {
    ./configure --noninteractive || die
    make OPTIMIZER="${CFLAGS}" || die
}

src_install() {
    dodir /usr/{bin,lib,share/man,share/doc/${PF}/html}
    dodir /usr/share/doc/${PF}/html
    make install || die
    prepalldocs
    
#    rm ${D}/usr/lib/libtiff.so.3
#    mv ${D}/usr/lib/libtiff.so.3.5. ${D}/usr/lib/libtiff.so.3.5.5
    preplib /usr
#    rm -rf ${D}/tiff.sw.tools
    
    dodoc COPYRIGHT README TODO VERSION
}
