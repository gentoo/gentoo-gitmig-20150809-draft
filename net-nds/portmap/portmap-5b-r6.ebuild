# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r6.ebuild,v 1.1 2001/09/16 19:14:30 agriffis Exp $

P=portmap-5b
A=portmap_5beta.tar.gz
A0=portmap_5beta.dif
S=$WORKDIR/portmap_5beta
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/$A"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

DEPEND="virtual/glibc
        sys-apps/tcp-wrappers"

src_unpack() {
    unpack $A
    cd $S || die
    patch -p0 < $FILESDIR/$A0 || die
    cp Makefile Makefile.orig
    sed -e "s/-O2/$CFLAGS/" Makefile.orig > Makefile || die
}

src_compile() {
    make || die
}

src_install() {
    mkdir -p $D/sbin $D/usr/sbin $D/usr/share/man/man8
    mkdir -p $D/etc/init.d $D/etc/runlevels/default
    install -m755 portmap $D/sbin
    install -m755 pmap_dump pmap_set $D/usr/sbin
    install -m644 portmap.8 pmap_dump.8 pmap_set.8 $D/usr/share/man/man8
    install -m755 $FILESDIR/portmap-$PVR $D/etc/init.d/portmap
    ln -s ../../init.d/portmap $D/etc/runlevels/default/portmap
    dodoc BLURB CHANGES README
}
