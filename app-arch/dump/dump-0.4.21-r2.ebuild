# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.21-r2.ebuild,v 1.2 2001/05/29 17:28:19 achim Exp $

P=dump-0.4b21
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="http://download.sourceforge.net/dump/${A}"
HOMEPAGE="http://dump.sourceforge.net"

DEPEND=">=sys-apps/e2fsprogs-1.19
        readline? ( >=sys-libs/readline-4.1-r2 >=sys-libs/ncurses-5.2 )"
RDEPEND="$DEPEND sys-apps/star"

src_unpack() {
    unpack ${A}
    cd ${S}
    for i in dump-main.c dump-optr.c
    do
      patch -p0 < ${FILESDIR}/${PN}-${PV}-${i}-gentoo.diff
    done
}

src_compile() {

    local myconf
    if [ "`use readline`" ]
    then
      myconf=--enable-readline
      ln -s /lib/libncurses.so libtermcap.so
      export LDFLAGS="-L${S}"
      export CFLAGS="$CFLAGS -L${S}"
    fi

    try ./configure --prefix=/usr --host=${CHOST} \
        --enable-largefile ${myconf}
    try make

}

src_install () {

    dodir /sbin
    dodir /usr/share/man/man8
    dodir /etc/dumpdates
    try make BINDIR=${D}/sbin MANDIR=${D}/usr/share/man/man8 \
	DUMPDATESPATH=${D}/etc/dumpdates install

    dodoc CHANGES COPYRIGHT KNOWNBUGS MAINTAINERS
    dodoc README REPORTING-BUGS THANKS TODO

	cd ${D}/sbin
	rm rdump
	ln -s dump rdump
	rm rrestore
	ln -s restore rrestore

}

