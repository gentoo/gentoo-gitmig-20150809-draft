# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-sound/teknap/teknap-1.3f.ebuild,v 1.1 2001/07/03 10:44:43 achim Exp $

P=TekNap-${PV}
A=${P}.tar.gz
S=${WORKDIR}/TekNap
DESCRIPTION="TekNap is a console Napster/OpenNap client"
SRC_URI="ftp://ftp.teknap.com/pub/TekNap/${A}"
HOMEPAGE="http://www.TekNap.com/"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2
        gtk? ( >=x11-libs/gtk+-1.2.10 )
        tcpd? ( sys-apps/tcp-wrappers )
        xmms? ( media-sound/xmms )"

src_compile() {
    local myconf
    if [ "`use gtk`" ] ; then
      myconf="--with-gtk"
    fi
    if [ "`use tcpd`" ] ; then
      myconf="$myconf --enable-wrap"
    fi
    if [ "`use xmms`" ] ; then
      myconf="$myconf --enable-xmms"
    fi

    try ./configure --prefix=/usr --mandir=/usr/share/man --enable-cdrom --enable-ipv6 $myconf --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr mandir=${D}/usr/share/man install
    rm ${D}/usr/bin/TekNap
    dosym TekNap-1.3f /usr/bin/TekNap
    dodoc COPYRIGHT README TODO Changelog
    docinto txt
    cd doc
    dodoc *.txt TekNap.faq bugs link-guidelines macosx.notes
    doman TekNap.1
}

