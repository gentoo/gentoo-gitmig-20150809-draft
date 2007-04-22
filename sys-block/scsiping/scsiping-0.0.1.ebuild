# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/scsiping/scsiping-0.0.1.ebuild,v 1.7 2007/04/22 13:52:53 dertobi123 Exp $

DESCRIPTION="SCSIPing pings a host on the SCSI-chain"
HOMEPAGE="http://www.vanheusden.com/Linux/"
SRC_URI="http://www.vanheusden.com/Linux/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	sed -i -e '/strip scsiping/d' ${S}/Makefile
}

src_compile() {
	emake DEBUG='' CFLAGS="${CFLAGS}"
}

src_install() {
	dosbin scsiping
}

pkg_postinst() {
	ewarn "WARNING: using scsiping on a device with mounted partitions may be hazardous to your system!"
}
