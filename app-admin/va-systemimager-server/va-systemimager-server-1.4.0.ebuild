# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/va-systemimager-server/va-systemimager-server-1.4.0.ebuild,v 1.8 2002/10/04 03:47:09 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VA SystemImager software automates the installation of Linux to masses of similar machines."
SRC_URI="http://download.sourceforge.net/systemimager/${P}.tar.bz2"
HOMEPAGE="http://systemimager.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_install () {

	DESTDIR=${D} ./install --no-afterburner --quiet || die
	insinto /etc/rsync
	newins ${FILESDIR}/${P}-rsyncd.conf rsyncd.conf
	dosed "s:/etc/rsyncd\.conf:/etc/rsyncd/rsyncd.conf:" /usr/sbin/getimage
	dodir /var/{log/systemimager,spool/systemimager}
	rm -r ${D}/etc/rc.d
}
