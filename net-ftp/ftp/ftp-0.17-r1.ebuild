# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r1.ebuild,v 1.4 2001/05/28 05:24:13 achim Exp $

A=netkit-${P}.tar.gz
S=${WORKDIR}/netkit-${P}
DESCRIPTION="Standard Linux FTP client"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {              
    
    try ./configure --prefix=/usr
    cp MCONFIG MCONFIG.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" MCONFIG.orig > MCONFIG
    try make
}

src_install() {                               
    into /usr
    dobin ftp/ftp
    doman ftp/ftp.1 ftp/netrc.5
    dodoc ChangeLog README BUGS
}


