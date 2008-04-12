# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/kthinkbat/kthinkbat-0.2.9.ebuild,v 1.1 2008/04/12 18:36:16 dirtyepic Exp $

inherit kde

DESCRIPTION="A ThinkPad Battery Viewer Applet"
HOMEPAGE="https://lepetitfou.dyndns.org/KThinkBat"
SRC_URI="http://lepetitfou.dyndns.org/download/kthinkbat/src/kthinkbat-0.2.x/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="smapi"

DEPEND=""
RDEPEND="smapi? ( app-laptop/tp_smapi )"

need-kde 3.3

src_install() {
	kde_src_install
	dodoc COPYING* Contributors README
}

pkg_postinst() {
	einfo
	einfo "KThinkBat can make use of the SMAPI BIOS interface found on most"
	einfo "ThinkPads. "
	einfo
	einfo "If you want to use this feature, make sure you have"
	einfo "the kernel module tp_smapi (from app-laptop/tp_smapi)"
	einfo "loaded."
	einfo
	einfo "To autoload this kernel module at system startup type"
	einfo
	einfo "  # echo \"tp_smapi\" >> /etc/modules.autoload.d/kernel-2.6"
	einfo

	buildsycoca
}

src_install() {
	kde_src_install
	dodoc COPYING* Contributors README
}
