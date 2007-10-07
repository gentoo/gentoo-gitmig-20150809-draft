# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/linux-fusion/linux-fusion-7.0.1.ebuild,v 1.2 2007/10/07 17:11:08 vapier Exp $

inherit eutils linux-mod

DESCRIPTION="provide statistical information for the Linux /proc file system"
HOMEPAGE="http://directfb.org/wiki/index.php/Fusion_Proc_Filesystem"
SRC_URI="http://directfb.org/downloads/Core/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

MODULE_NAMES="fusion(drivers/char:${S}:${S}/linux/drivers/char/fusion)"
BUILD_TARGETS="all"
MODULESD_REALTIME_DOCS="AUTHORS ChangeLog README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	convert_to_m Makefile
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins "${S}"/linux/include/linux/fusion.h || die
	dodoc README ChangeLog TODO
	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/fusion.udev 60-fusion.rules
}
