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


src_compile() {
    try ./configure --host=$${CHOST} --prefix=/usr \
        --enable-editcomplete --program-prefix=lukemftp

    try make
}

src_install() {
    newbin src/ftp lukemftp
    newman src/ftp.1 lukemftp.1
    dodoc COPYING ChangeLog README* THANKS NEWS

    cd ${D}/usr/bin
    if [ ! -e /usr/bin/ftp ]; then
        ln -s lukemftp ftp
    fi
}
