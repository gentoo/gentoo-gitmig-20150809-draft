# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r1.ebuild,v 1.3 2000/09/15 20:09:15 drobbins Exp $

P=portmap-5b
A=portmap_5beta.tar.gz
A0=portmap_5beta.dif
S=${WORKDIR}/portmap_5beta
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/"${A}
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

src_compile() {
    try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${O}/files/${A0}
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() { 
                
	cd ${S}
	into /
	dosbin portmap
	into /usr
	dosbin pmap_dump pmap_set
	doman portmap.8 pmap_dump.8 pmap_set.8
	dodir /etc/rc.d/init.d
	cp ${O}/files/portmap ${D}/etc/rc.d/init.d
	dodoc BLURB CHANGES README
}

pkg_config() {

    source ${ROOT}/etc/rc.d/config/functions

    einfo "Generating symlinks..."
    ${ROOT}/usr/sbin/rc-update add portmap

}
