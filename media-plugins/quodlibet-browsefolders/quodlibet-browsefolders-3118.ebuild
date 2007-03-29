# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-browsefolders/quodlibet-browsefolders-3118.ebuild,v 1.3 2007/03/29 08:24:30 corsair Exp $

inherit python

DESCRIPTION="Quod Libet plugin that opens a configured program on the songs' folders"
HOMEPAGE="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/songsmenu/browsefolders.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.20"

PLUGIN_DEST="/usr/share/quodlibet/plugins/songsmenu"

src_install() {
	insinto ${PLUGIN_DEST}
	doins ${S}.py
}

pkg_postinst() {
	python_mod_compile ${PLUGIN_DEST}/${P}.py
}

pkg_postrm() {
	python_mod_cleanup ${PLUGIN_DEST}
}
