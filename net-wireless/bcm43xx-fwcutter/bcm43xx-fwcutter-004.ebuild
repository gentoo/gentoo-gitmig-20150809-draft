# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bcm43xx-fwcutter/bcm43xx-fwcutter-004.ebuild,v 1.2 2006/04/21 13:07:42 josejx Exp $

DESCRIPTION="Firmware Tool for Broadcom 43xx based wireless network devices"
HOMEPAGE="http://bcm43xx.berlios.de"
SRC_URI="http://download.berlios.de/bcm43xx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND=""
RDEPEND=">=sys-apps/hotplug-20040923-r1"

src_install() {
	# Install fwcutter
	exeinto /usr/bin
	doexe ${PN}
	doman ${PN}.1
	dodoc README
}

pkg_postinst() {
	if ! [ -f /lib/firmware/${PN}_microcode2.fw ]; then
		einfo
		einfo "You'll need to use bcm43xx-fwcutter to install the bcm43xx firmware."
		einfo "Please read the bcm43xx-fwcutter readme for more details:"
		einfo "/usr/share/doc/${P}/README.gz"
		einfo
	fi

	einfo "Please read this forum thread for help and troubleshooting:"
	einfo "http://forums.gentoo.org/viewtopic-t-409194.html"
	einfo
}
