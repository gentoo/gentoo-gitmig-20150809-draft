# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Copyright 2003  DmD Ljungmark ( spider@gentoo.org )
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrw-base/cdrw-base-0.2.ebuild,v 1.4 2004/02/22 18:01:33 agriffis Exp $

DESCRIPTION="Configuration files to make CD recording easier"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""
DEPEND="sys-fs/devfsd"
S=${WORKDIR}/${P}


src_compile () {
	echo  ""
}

src_install() {
	insinto /etc/devfs.d   ; newins ${FILESDIR}/devfs-${PV} cdrw
	insinto /etc/modules.d ; newins ${FILESDIR}/modules-${PV} cdrw
}
