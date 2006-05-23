# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/scsiping/scsiping-0.0.1.ebuild,v 1.3 2006/05/23 01:54:06 robbat2 Exp $

DESCRIPTION="SCSIPing pings a host on the SCSI-chain"
HOMEPAGE="http://www.vanheusden.com/Linux/"
SRC_URI="http://www.vanheusden.com/Linux/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="${RDEPEND}"

src_compile() {
	emake DEBUG=''
}

src_install() {
	dosbin scsiping
}

pkg_postinst() {
	ewarn "WARNING: using scsiping on a device with mounted partitions may be hazardous to your system!"
}
