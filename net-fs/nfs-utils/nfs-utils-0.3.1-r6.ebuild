# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Originally written by Achim Gottinger <achim@gentoo.org>
# Heavily updated for nfs-utils-0.3.1 by Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-0.3.1-r6.ebuild,v 1.3 2001/09/24 17:19:23 lamer Exp $

A=$P.tar.gz
S=$WORKDIR/$P
DESCRIPTION="kernel NFS daemons"
SRC_URI="http://download.sourceforge.net/nfs/$A"
HOMEPAGE="http://nfs.sourceforge.net/"

DEPEND="virtual/glibc
	tcpd? ( sys-apps/tcp-wrappers )"

RDEPEND="virtual/glibc
         >=net-nds/portmap-5b-r6"

src_unpack() {
    unpack $A || die
    cd $S || die
    patch -p1 < $FILESDIR/$PF-gentoo.diff || die
}

src_compile() {
    ./configure \
	--prefix=/ \
	--mandir=/usr/share/man \
	--with-statedir=/var/lib/nfs \
	--enable-nfsv3 || die
    if ! use tcpd; then
      cp config.mk config.mk.orig
      sed -e "s:-lwrap::" -e "s:-DHAVE_TCP_WRAPPER::" \
	config.mk.orig > config.mk
    fi
    make || die
}

src_install() {
    # MANDIR doesn't pick up install_prefix
    make install install_prefix=$D MANDIR=$D/usr/share/man 
	 into /etc
	 newins $FILESDIR/exports-${PVR} exports
    dodoc ChangeLog COPYING README
    docinto linux-nfs
    dodoc linux-nfs/*
    dodir /etc/init.d 
	 dodir /etc/runlevels/default
	 exeinto /etc/init.d
    newexe ${FILESDIR}/nfs-${PVR} nfs
    newexe ${FILESDIR}/nfsmount-${PVR} nfsmount 
    ln -s $D/etc/rc.d/init.d/nfs{,mount} $D/etc/runlevels/default 
}
