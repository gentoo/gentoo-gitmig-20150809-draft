# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-cddb/quodlibet-cddb-3198.ebuild,v 1.2 2007/03/29 08:33:10 corsair Exp $

inherit python

DESCRIPTION="CDDB lookup plugin for Quod Libet."
HOMEPAGE="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/songsmenu/cddb.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.20.1
	dev-python/cddb-py"

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
