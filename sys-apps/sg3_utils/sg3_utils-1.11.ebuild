# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.11.ebuild,v 1.1 2004/11/28 19:16:14 plasmaroo Exp $

inherit eutils

DESCRIPTION="Sg3_utils provide a collection of programs that use the sg SCSI interface. Contains rescan_scsi_bus.sh."
HOMEPAGE="http://www.torque.net/sg/"
SRC_URI="http://www.torque.net/sg/p/${P}.tgz
	http://www.garloff.de/kurt/linux/rescan-scsi-bus.sh"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tgz
	cd ${S}

	epatch ${FILESDIR}/${PN}-llseek.patch
	sed -i "s:-O2:$CFLAGS:g" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe ${DISTDIR}/rescan-scsi-bus.sh || die 'Failed to install rescan-scsi-bus.sh!'
	einstall DESTDIR=${D} PREFIX=/usr || die 'Failed to install sg3_utils!'
}
