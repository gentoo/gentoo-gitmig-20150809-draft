# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/noflushd/noflushd-2.4.ebuild,v 1.3 2001/08/02 19:59:33 danarmak Exp $
# Note: the daemon's current 2.4 version has nothing to do with kernel versions

#P=""
A=noflushd_2.4.orig.tar.gz
S=${WORKDIR}/${P}.orig
SRC_URI="http://download.sourceforge.net/noflushd/${A}"

HOMEPAGE="http://noflushd.sourceforge.net"
DESCRIPTION="A daemon to spin down your disks and force accesses to be cached"

DEPEND=""

src_compile() {
    
    confopts="--infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} --with-docdir=/usr/share/doc/${P}"
    
    try ./configure ${confopts}
    
    try emake

}

src_install () {
    
    # The orig. noflushd includes startup scripts for suse, debian and redhat.
    # It detects gentoo as redhat (at least here it does), and in any case
    # we don't want any of its rc.d scripts, so we install manually. There's
    # only one binary and the docs.
    
    cd ${S}
    
    into /usr
    dosbin src/noflushd
    doman man/noflushd.8
    
    dodoc README NEWS
    
    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/noflushd
    
    insinto /etc
    doins ${FILESDIR}/noflushd.conf
    
}

pkg_postinst() {
    
    echo "
    Run 'rc-update add noflushd' to add it to runlevels 2 3 4.

    Edit /etc/noflushd.conf to change the default spindown
    timeout and the disks handled; the defaults are 60 minutes
    and /dev/discs/disc0/disc (i.e. hda).

    WARNING:
    WARNING: Do NOT use with SCSI, unstable!
    WARNING:
    "
    
}