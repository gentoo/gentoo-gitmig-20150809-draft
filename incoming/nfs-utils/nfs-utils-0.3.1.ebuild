# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Originally written by Achim Gottinger <achim@gentoo.org>
# Heavily updated for nfs-utils-0.3.1 by Aron Griffis <agriffis@zk3.dec.com>
# $Header: /var/cvsroot/gentoo-x86/incoming/nfs-utils/nfs-utils-0.3.1.ebuild,v 1.1 2001/08/18 13:23:52 danarmak Exp $

A=$P.tar.gz
S=$WORKDIR/$P
DESCRIPTION="kernel NFS daemons"
SRC_URI="http://download.sourceforge.net/nfs/$A"
HOMEPAGE="http://nfs.sourceforge.net/"

DEPEND="virtual/glibc
	tcpd? ( sys-apps/tcp-wrappers )"

RDEPEND="virtual/glibc net-nds/portmap"

src_unpack() {
    cd $WORKDIR
    unpack $A || die
    # unpack apparently doesn't understand normal tar files :-(
    tar xvf $FILESDIR/$PF-files.tar || die
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
    make install install_prefix=$D MANDIR=$D/usr/share/man || die
    mkdir -p $D/etc/rc.d/init.d
    install -m 755 $WORKDIR/nfs $D/etc/rc.d/init.d || die
    install -m 755 $WORKDIR/nfsmount $D/etc/rc.d/init.d || die
    install -m 644 $WORKDIR/exports $D/etc || die
    dodoc ChangeLog COPYING README
    docinto linux-nfs
    dodoc linux-nfs/*
}

pkg_postinst() {
    . $ROOT/etc/rc.d/config/functions
    . $ROOT/var/db/pkg/install.config

    echo "Generating symlinks..."
    $ROOT/usr/sbin/rc-update add nfs
    $ROOT/usr/sbin/rc-update add nfsmount

    # This is from Achim's ebuild of nfs-utils, but it doesn't
    # make sense to me that we're setting up the user's NFS server for
    # them, so I'm commenting it out for now. (17 Aug 2001 agriffis)
    #if [ -n "$nfsserver_home" ]
    #then
    #    echo "Export Homedirs..."
    #    cp $ROOT/etc/exports $ROOT/etc/exports.orig
    #    sed -e "s:^#nfsserver_home:$nfsserver_home:" \
    #        -e "s/eth0_net/$eth0_net/" \
    #        -e "s/eth0_mask/$eth0_mask/" \
    #        $ROOT/etc/exports.orig > $ROOT/etc/exports
    #fi

    return 0
}

pkg_prerm() {
    . $ROOT/etc/rc.d/config/functions
    . $ROOT/var/db/pkg/install.config

    echo "Removing symlinks..."
    $ROOT/usr/sbin/rc-update del nfsserver
    $ROOT/usr/sbin/rc-update del nfsmount
    $ROOT/usr/sbin/rc-update del nfsstatd

    return 0
}
