# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-1.3.1-r2.ebuild,v 1.4 2001/06/09 07:10:17 achim Exp $

P=ntop-1.3.1
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Unix Tool that shows networkusage like top"
SRC_URI="ftp://ftp.it.ntop.org/pub/local/ntop/snapshots/${A}"
HOMEPAGE="http://www.ntop.org/ntop.html"

DEPEND="virtual/glibc sys-devel/gcc
	>=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
        >=net-libs/libpcap-0.5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="virtual/glibc sys-devel/gcc
	>=sys-libs/gdbm-1.8.0
        >=sys-libs/ncurses-5.1
        >=sys-libs/readline-4.1
	ssl? ( >=dev-libs/openssl-0.9.6 )"

# tcpd? ( >=sys-apps/tcp-wrappers-7.6 ) does not work atm

src_unpack() {
    unpack ${A}
    cp ${FILESDIR}/main.c ${S}/main.c
}
src_compile() {

    local myconf
    if [ -z "`use ssl`" ] ; then
        myconf="--disable-ssl"
    else
        cp configure configure.orig
        sed -e "s:/usr/local/ssl:/usr:" configure.orig > configure
        export CFLAGS="$CFLAGS -I/usr/include/openssl"
    fi
    #if [ "`use tcpd`" ] ; then
    #    myconf="$myconf --enable-tcpwrap"
    #fi
    touch *
    try ./configure --prefix=/usr --sysconfdir=/usr/share --mandir=/usr/share/man --host=${CHOST}  $myconf
    try make

}

src_install () {


    try make prefix=${D}/usr sysconfdir=/${D}/usr/share mandir=${D}/usr/share/man install
    mv ${D}/usr/bin/plugins ${D}/usr/share/ntop

    dodoc AUTHORS ChangeLog CONTENTS COPYING FAQ FILES HACKING
    dodoc KNOWN_BUGS MANIFESTO NEWS ntop.txt PORTING README*
    dodoc SUPPORT* THANKS THREADS-FAQ TODO
    docinto html
    dodoc ntop.html
}



