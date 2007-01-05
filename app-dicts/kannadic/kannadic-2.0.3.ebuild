# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/kannadic/kannadic-2.0.3.ebuild,v 1.9 2007/01/05 16:06:50 flameeyes Exp $

inherit kde

DESCRIPTION="Canna, Anthy and Dixchange dictionary editor for KDE"
HOMEPAGE="http://linux-life.net/program/cc/kde/app/kannadic/"
SRC_URI="http://linux-life.net/program/cc/kde/app/kannadic/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="app-i18n/canna"
RDEPEND="${DEPEND}"

need-kde 3

pkg_postinst() {
	elog
	elog "Currently KannaDic doesn't create a dictionary for you,"
	elog "so you need to create one manually."
	elog "e.g) If you are going to add user dictionary named \"personal\", run"
	elog
	elog "\t% mkdic user"
	elog
	elog "and add [1m:user \"personal\"[0m to (use-dictionary ...) in your ~/.canna"
	elog "You may need to restart canna server in order to use your dictionary."
	elog
}
