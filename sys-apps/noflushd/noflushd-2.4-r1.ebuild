# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/noflushd/noflushd-2.4-r1.ebuild,v 1.2 2001/08/02 19:57:40 danarmak Exp $
# Note: the daemon's current 2.4 version has nothing to do with kernel versions

#P=""
A=noflushd_2.4.orig.tar.gz
S=${WORKDIR}/${P}.orig
SRC_URI="http://download.sourceforge.net/noflushd/${A}"

HOMEPAGE="http://noflushd.sourceforge.net"
DESCRIPTION="A daemon to spin down your disks and force accesses to be cached"

DEPEND="sys-devel/ld.so virtual/glibc"

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
    
    insinto /etc/rc.d/config
    # update from previous (-r0) location of config file
    if [ -x /etc/noflushd.conf ] ;
    then
	doins /etc/noflushd.conf
    else
        doins ${FILESDIR}/noflushd.conf
    fi
    
}

pkg_postinst() {
    
    echo "
    Run 'rc-update add noflushd' to add it to runlevels 2 3 4.

    Edit /etc/noflushd.conf to change the default spindown
    timeout and the disks handled; the defaults are 60 minutes
    and /dev/discs/disc0/disc (i.e. hda).
    
    NOTE FOR UPDATE:
    The original version of this ebuild used /etc/env.d/70noflushd
    for settings, the next version used /etc/noflushd.conf, and finally
    this new version (-r1) uses /etc/rc.d/config/noflushd.conf. If you 
    had a config file in the previous location and none in the new one,
    it will have been copied to the new one (the syntax is identical).
    
    If you updated, you MUST go to /etc/rc.d/init.d and replace the old
    noflushd init script with the new one if you have the default config
    dir protection!

    WARNING:
    WARNING: Do NOT use with SCSI, unstable!
    WARNING:
    "
    
}