# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw3945-ucode/ipw3945-ucode-1.13.ebuild,v 1.3 2006/12/28 22:24:14 peper Exp $

DESCRIPTION="Microcode for the Intel PRO/Wireless 3945ABG miniPCI express adapter"

HOMEPAGE="http://www.bughost.org/ipw3945/"
SRC_URI="http://www.bughost.org/ipw3945/${P}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="~amd64 x86"

IUSE=""
DEPEND=">=sys-apps/hotplug-20040923"

src_install() {
	insinto /lib/firmware
	doins ipw3945.ucode LICENSE.ipw3945-ucode

	dodoc README.ipw3945-ucode
}
