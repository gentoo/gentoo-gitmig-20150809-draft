# Copyright 2000-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Michael Nazaroff <newandcreative@yahoo.com>
# net-ftp/ftp/lukemftp-1.5-r1.ebuild,v 1

P=lukemftp-1.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="NetBSD FTP client"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/misc/lukemftp/${A}"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.1"

src_unpack() {

    unpack ${A}
    cd ${S}

    # Adds a command line option: -s, which produces clean, informative output.
    # Shows progess status, ETA, transfer speed, no server responses or login messages.
    cp src/main.c src/main.orig
    sed -e "s/Aadefgino:pP:r:RtT:u:vV/Aadefgino:pP:r:RstT:u:vV/" \
        -e "s/case 't'/case 's':\n\t\t\tverbose = 0;\n\t\t\tprogress = 1;\n\t\t\tbreak;\n\n\t\t&/" \
        src/main.orig > src/main.c
}

src_compile() {
    try ./configure --host=${CHOST} --prefix=/usr \
        --enable-editcomplete --program-prefix=lukemftp

    try make
}

src_install() {
    newbin src/ftp lukemftp
    newman src/ftp.1 lukemftp.1
    dodoc COPYING ChangeLog README* THANKS NEWS

    if [ ! -e /usr/bin/ftp ]; then
        cd ${D}/usr/bin
        ln -s lukemftp ftp
    fi
}
