# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.24.ebuild,v 1.1 2001/09/29 15:13:36 agriffis Exp $

P=dump-0.4b24
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="http://download.sourceforge.net/dump/${A}"
HOMEPAGE="http://dump.sourceforge.net"

DEPEND=">=sys-apps/e2fsprogs-1.19
        readline? ( >=sys-libs/readline-4.1-r2 >=sys-libs/ncurses-5.2 )
	>=sys-kernel/linux-headers-2.4.10"

RDEPEND=">=sys-apps/e2fsprogs-1.19
         readline? ( >=sys-libs/readline-4.1-r2 >=sys-libs/ncurses-5.2 )
	 sys-apps/star"

src_compile() {
    local myconf
    if use readline; then
	myconf=--enable-readline
	ln -s /lib/libncurses.so libtermcap.so
	export LDFLAGS="-L${S}"
	export CFLAGS="$CFLAGS -L${S}"
    fi

    ./configure --prefix=/usr --host=${CHOST} --enable-largefile ${myconf}
    assert "./configure failed (myconf=$myconf)"

    emake 
    assert "emake failed (myconf=$myconf)"
}

src_install () {
    dodir /sbin
    dodir /usr/share/man/man8
    dodir /etc/dumpdates
    make BINDIR=${D}/sbin MANDIR=${D}/usr/share/man/man8 \
	DUMPDATESPATH=${D}/etc/dumpdates install || die "make install failed"

    dodoc CHANGES COPYRIGHT KNOWNBUGS MAINTAINERS
    dodoc README REPORTING-BUGS THANKS TODO

    cd ${D}/sbin
    rm -f rdump rrestore
    ln -s dump rdump
    ln -s restore rrestore
}
