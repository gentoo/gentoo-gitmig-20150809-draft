# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/va-systemimager-server/va-systemimager-server-1.4.0.ebuild,v 1.5 2002/07/17 20:43:17 drobbins Exp $


S=${WORKDIR}/${P}
DESCRIPTION="VA SystemImager software automates the installation of Linux to masses of similar machines."
SRC_URI="http://download.sourceforge.net/systemimager/${P}.tar.bz2"
SLOT="0"
HOMEPAGE="http://systemimager.org"
LICENSE="GPL-2"

src_install () {


    try DESTDIR=${D} ./install --no-afterburner --quiet
    insinto /etc/rsync
    newins ${FILESDIR}/${P}-rsyncd.conf rsyncd.conf
    dosed "s:/etc/rsyncd\.conf:/etc/rsyncd/rsyncd.conf:" /usr/sbin/getimage
    dodir /var/{log/systemimager,spool/systemimager}
    rm -r ${D}/etc/rc.d
}

