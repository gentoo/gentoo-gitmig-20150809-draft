# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Originally written by Achim Gottinger <achim@gentoo.org>
# Heavily updated for nfs-utils-0.3.1 by Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-0.3.1-r1.ebuild,v 1.1 2001/08/29 16:07:46 agriffis Exp $

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
    install -m 755 $FILESDIR/nfs-$PVR $D/etc/rc.d/init.d/nfs || die
    install -m 755 $FILESDIR/nfsmount-$PVR $D/etc/rc.d/init.d/nfsmount || die
    install -m 644 $FILESDIR/exports-$PVR $D/etc/exports || die
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
    return 0
}

# On Red Hat, this would be the appropriate approach.  $1 would be
# tested to determine how many instances of this ebuild will be
# installed at the end of this procedure.  If $1==0, then remove the
# symlinks.
#
# But this isn't Red Hat, and there's no (official) way to determine
# the answer to this question.  So instead we'll just leave the dead
# links hanging around until the new dependency-based init.d system is
# in place...
#
# pkg_prerm() {
#     . $ROOT/etc/rc.d/config/functions
#     . $ROOT/var/db/pkg/install.config
# 
#     echo "Removing symlinks..."
#     $ROOT/usr/sbin/rc-update del nfs
#     $ROOT/usr/sbin/rc-update del nfsmount
# 
#     return 0
# }
