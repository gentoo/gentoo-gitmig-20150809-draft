# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/va-systemimager-server/va-systemimager-server-1.4.0.ebuild,v 1.1 2001/04/17 15:54:59 achim Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="VA SystemImager software automates the installation of Linux to masses of similar machines."
SRC_URI="http://download.sourceforge.net/systemimager/${A}"
HOMEPAGE="http://systemimager.org"


src_install () {


    try DESTDIR=${D} ./install --no-afterburner --quiet
    insinto /etc/rsync
    newins ${FILESDIR}/${P}-rsyncd.conf rsyncd.conf
    dosed "s:/etc/rsyncd\.conf:/etc/rsyncd/rsyncd.conf:" /usr/sbin/getimage
    dodir /var/{log/systemimager,spool/systemimager}
    rm -r ${D}/etc/rc.d
}

