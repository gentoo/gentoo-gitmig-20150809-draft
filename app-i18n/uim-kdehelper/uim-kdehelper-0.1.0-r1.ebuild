# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-kdehelper/uim-kdehelper-0.1.0-r1.ebuild,v 1.1 2004/11/09 18:05:42 usata Exp $

inherit kde

S="${WORKDIR}/${PN}"

DESCRIPTION="Qt replacement of toolbar, system tray, applet and candidate window for UIM library."
HOMEPAGE="http://uim.freedesktop.org/Software/uim-kdehelper"
SRC_URI="http://freedesktop.org/~kzk/uim-kdehelper/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-i18n/uim"

need-kde 3
need-qt 3.2

pkg_postinst() {
	einfo
	einfo "If you want to use uim-candwin-qt instead of gtk one,"
	einfo "set UIM_CANDWIN_PROG to uim-candwin-qt."
	einfo "% export UIM_CANDWIN_PROG=\"uim-candwin-qt\" (bash)"
	einfo "> setenv UIM_CANDWIN_PROG \"uim-candwin-qt\" (csh)"
	einfo
}
