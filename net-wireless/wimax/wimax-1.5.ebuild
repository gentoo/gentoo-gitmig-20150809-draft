# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wimax/wimax-1.5.ebuild,v 1.1 2010/07/25 14:18:17 alexxy Exp $

EAPI="3"

inherit linux-info multilib

DESCRIPTION="Intel WiMAX daemon used to interface to the hardware"
HOMEPAGE="http://www.linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libnl-1.1
		>=sys-kernel/linux-headers-2.6.34"
RDEPEND="${DEPEND}
	net-wireless/wimax-tools
	net-wireless/wpa_supplicant[wimax]"

src_prepare() {
	use amd64 && sed -i 's:REG_EIP:REG_RIP:g' \
		InfraStack/OSDependent/Linux/InfraStackModules/Skeletons/AppSrv/GenericConsole.c \
			|| die "Sed failed"
}

src_configure() {
	econf \
		--with-libwimaxll=/usr/$(get_libdir) \
		--with-i2400m=/usr || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	doinitd "${FILESDIR}"/wimax || die "failed to place the init daemon"
}
