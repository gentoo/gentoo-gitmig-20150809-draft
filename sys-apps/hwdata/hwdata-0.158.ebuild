# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata/hwdata-0.158.ebuild,v 1.1 2005/11/16 15:45:56 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Hardware information used by hwsetup and other utilities"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~wolf31o2/sources/hwdata/${P}.tar.gz"
HOMEPAGE="http://www.knopper.net"

IUSE="livecd opengl"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="!sys-apps/hwdata-knoppix"

src_unpack() {
	unpack ${A}
	use x86 && use livecd && use opengl && \
		epatch ${FILESDIR}/${P}-binary_drivers.patch
	use amd64 && use livecd && use opengl && \
		epatch ${FILESDIR}/${P}-binary_drivers_nv.patch
}

src_install() {
	insinto /usr/share/hwdata
	doins CardMonitorCombos Cards MonitorsDB pcitable upgradelist usb.ids \
	pci.ids
}
