# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.11.ebuild,v 1.3 2005/03/14 04:59:17 vapier Exp $

inherit eutils

DESCRIPTION="apps for querying the sg SCSI interface (contains rescan_scsi_bus.sh)"
HOMEPAGE="http://www.torque.net/sg/"
SRC_URI="http://www.torque.net/sg/p/${P}.tgz
	http://www.garloff.de/kurt/linux/rescan-scsi-bus.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tgz
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-llseek.patch
	sed -i "s:-O2:$CFLAGS:g" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin ${DISTDIR}/rescan-scsi-bus.sh || die 'Failed to install rescan-scsi-bus.sh!'
	einstall DESTDIR="${D}" PREFIX=/usr || die 'Failed to install sg3_utils!'
}
