# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r1.ebuild,v 1.3 2000/11/01 04:44:19 achim Exp $

P=ftp-0.17    
A=netkit-${P}.tar.gz
S=${WORKDIR}/netkit-${P}
DESCRIPTION="Standard Linux FTP client"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"

src_compile() {              
    cd ${S}             
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


