# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lsscsi/lsscsi-0.12.ebuild,v 1.1 2004/07/08 23:18:46 rac Exp $

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://www.torque.net/scsi/lsscsi.html"
SRC_URI="http://www.torque.net/scsi/lsscsi-0.12.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

src_compile() {
	emake PREFIX="/usr" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	cd ${S}
	dodir /usr/bin
	insinto /usr/bin
	dobin lsscsi
	doman lsscsi.8
}
