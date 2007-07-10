# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.16.2.ebuild,v 1.2 2007/07/10 13:40:17 zzam Exp $

inherit eutils linux-mod

MY_P="${P/-modules/}"

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="mirror://sourceforge/dxr3/${MY_P}.tar.gz"

DEPEND="virtual/linux-sources"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

CONFIG_CHECK="I2C_ALGOBIT"
MODULE_NAMES="em8300(video:) bt865(video:) adv717x(video:)"

S="${WORKDIR}/${MY_P}/modules"

src_unpack() {
	unpack ${A}
	cd "${S}/.."
	epatch "${FILESDIR}/${P}-pci-module-init.patch"
}

src_compile() {
	set_arch_to_kernel
	cd "${S}"
	emake KERNEL_LOCATION="${KERNEL_DIR}" || die "emake failed."
}

src_install() {
	linux-mod_src_install

	dodoc README-modoptions README-modules.conf

	newsbin devices.sh em8300-devices.sh

	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300

	insinto /etc/udev/rules.d
	newins em8300-udev.rules 15-em8300.rules
}
