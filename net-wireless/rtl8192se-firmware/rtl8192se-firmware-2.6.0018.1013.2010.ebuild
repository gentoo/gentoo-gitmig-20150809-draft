# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl8192se-firmware/rtl8192se-firmware-2.6.0018.1013.2010.ebuild,v 1.2 2010/10/23 11:54:06 chithanh Exp $

EAPI=3

MY_P="${P/-firmware-/_linux_}"

DESCRIPTION="RTL8191SE/8192SE wireless chipset firmware"
HOMEPAGE="http://www.realtek.com.tw/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

S=${WORKDIR}/${MY_P}/firmware/RTL8192SE

src_install() {
	insinto /lib/firmware/RTL8192SE
	doins *.bin || die
}
