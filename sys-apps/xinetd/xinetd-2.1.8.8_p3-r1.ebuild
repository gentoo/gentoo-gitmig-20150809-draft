# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.1.8.8_p3-r1.ebuild,v 1.4 2000/11/30 23:14:35 achim Exp $

P=xinetd-2.1.8.8p3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Replacement for inetd."
HOMEPAGE="http://www.xinetd.org"
SRC_URI="http://www.xinetd.org/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04
	 >=sys-devel/perl-5.6"

src_compile() {                           
    try ./configure --with-loadavg --with-libwrap --prefix=/usr --host=${CHOST}
    # Parallel make does not work
    try make 

}

src_install() {                               
    cd ${S}
    try make prefix=${D}/usr install
    dodoc CHANGELOG README COPYRIGHT
    dodir /etc/rc.d/init.d
    cp ${O}/files/xinetd ${D}/etc/rc.d/init.d/xinetd
    cp ${O}/files/xinetd.conf ${D}/etc
}




