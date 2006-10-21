# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/kannadic/kannadic-2.0.3.ebuild,v 1.8 2006/10/21 13:57:43 carlo Exp $

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
	einfo
	einfo "Currently KannaDic doesn't create a dictionary for you,"
	einfo "so you need to create one manually."
	einfo "e.g) If you are going to add user dictionary named \"personal\", run"
	einfo
	einfo "\t% mkdic user"
	einfo
	einfo "and add [1m:user \"personal\"[0m to (use-dictionary ...) in your ~/.canna"
	einfo "You may need to restart canna server in order to use your dictionary."
	einfo
}
