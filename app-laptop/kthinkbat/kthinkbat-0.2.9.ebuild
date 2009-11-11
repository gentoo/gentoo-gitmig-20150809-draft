# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/kthinkbat/kthinkbat-0.2.9.ebuild,v 1.6 2009/11/11 01:58:28 ssuominen Exp $

EAPI=1
ARTS_REQUIRED=never
inherit kde

DESCRIPTION="A ThinkPad Battery Viewer Applet"
HOMEPAGE="https://lepetitfou.dyndns.org/KThinkBat"
SRC_URI="http://lepetitfou.dyndns.org/download/kthinkbat/src/kthinkbat-0.2.x/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 x86"
IUSE="+smapi"

RDEPEND="smapi? ( app-laptop/tp_smapi )"
DEPEND=""

need-kde 3.5

src_install() {
	kde_src_install
	dodoc Contributors README
}

pkg_postinst() {
	elog
	elog "KThinkBat can make use of the SMAPI BIOS interface found on most"
	elog "ThinkPads. "
	elog
	elog "If you want to use this feature, make sure you have"
	elog "the kernel module tp_smapi (from app-laptop/tp_smapi)"
	elog "loaded."
	elog
	elog "To autoload this kernel module at system startup type"
	elog
	elog "  # echo \"tp_smapi\" >> /etc/modules.autoload.d/kernel-2.6"
	elog

	buildsycoca
}
