# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/linux-fusion/linux-fusion-8.1.1.ebuild,v 1.3 2010/04/09 02:53:33 jer Exp $

inherit eutils linux-mod

DESCRIPTION="provide statistical information for the Linux /proc file system"
HOMEPAGE="http://directfb.org/wiki/index.php/Fusion_Proc_Filesystem"
SRC_URI="http://directfb.org/downloads/Core/${P}.tar.gz
	http://directfb.org/downloads/Old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

MODULE_NAMES="fusion(drivers/char:${S}/linux/drivers/char/fusion)"
BUILD_TARGETS="modules"
MODULESD_REALTIME_DOCS="AUTHORS ChangeLog README"

src_unpack() {
	unpack ${A}
	cd "${S}"/linux/drivers/char/fusion
	ln -s Makefile-2.6 Makefile
}

src_compile() {
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}/linux/drivers/char/fusion CONFIG_FUSION_DEVICE=m EXTRA_CFLAGS=-I${S}/linux/include"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins "${S}"/linux/include/linux/fusion.h || die
	dodoc README ChangeLog TODO
	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/fusion.udev 60-fusion.rules
}
