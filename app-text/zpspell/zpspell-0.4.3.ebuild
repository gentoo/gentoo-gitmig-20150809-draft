# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zpspell/zpspell-0.4.3.ebuild,v 1.1 2009/05/07 21:04:41 serkan Exp $

inherit cmake-utils

DESCRIPTION="Zemberek-Pardus spell checker interface."
HOMEPAGE="http://www.pardus.org.tr/projeler/masaustu/zemberek-pardus"
SRC_URI="http://cekirdek.uludag.org.tr/~baris/zpspell/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/zemberek-server"

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS README || die
}

pkg_postinst() {
	elog "Please visit ${HOMEPAGE} for"
	elog "documentation on how to configure and run Zemberek spellchecker for KDE."
}
