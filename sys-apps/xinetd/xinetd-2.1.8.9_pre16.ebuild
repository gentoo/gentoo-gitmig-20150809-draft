# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.1.8.9_pre16.ebuild,v 1.1 2001/06/21 14:16:26 achim Exp $

P=${PN}-2.1.8.9pre16
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Replacement for inetd."
HOMEPAGE="http://www.xinetd.org"
SRC_URI="http://www.xinetd.org/${A}"
DEPEND="virtual/glibc
        tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

RDEPEND="virtual/glibc
         sys-devel/perl"

src_compile() {

    local myconf
    if [ "`use tcpd`" ]
    then
      myconf="--with-libwrap"
    fi
    try ./configure --with-loadavg --with-inet6 --prefix=/usr --mandir=/usr/share/man --host=${CHOST} $myconf
    # Parallel make does not work
    try make

}

src_install() {
    cd ${S}
    try make prefix=${D}/usr MANDIR=${D}/usr/share/man install
    dodoc CHANGELOG README COPYRIGHT
    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/xinetd ${FILESDIR}/svc-xinetd
	insinto /etc
	#doins ${FILESDIR}/xinetd.conf
	exeinto /var/lib/supervise/services/xinetd
	newexe ${FILESDIR}/xinetd-run run
}




