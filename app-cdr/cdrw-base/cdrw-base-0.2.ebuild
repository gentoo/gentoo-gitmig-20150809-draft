# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrw-base/cdrw-base-0.2.ebuild,v 1.9 2004/10/05 11:22:55 pvdabeel Exp $

DESCRIPTION="Configuration files to make CD recording easier"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha hppa amd64"
IUSE=""
DEPEND="sys-fs/devfsd"

src_compile () { :; }

src_install() {
	insinto /etc/devfs.d   ; newins ${FILESDIR}/devfs-${PV} cdrw
	insinto /etc/modules.d ; newins ${FILESDIR}/modules-${PV} cdrw
}
