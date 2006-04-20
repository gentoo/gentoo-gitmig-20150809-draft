# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-html/quodlibet-html-3133.ebuild,v 1.1 2006/04/20 14:24:14 tcort Exp $

inherit python

DESCRIPTION="Quod Libet plugin that generates a HTML playlist from selected songs."
HOMEPAGE="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/songsmenu/html.py"
SRC_URI="http://dev.gentoo.org/~tcort/quodlibet/plugins/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.19.1"

PLUGIN_DEST="${DESTDIR}/usr/share/quodlibet/plugins/songsmenu"

src_install() {
	insinto ${PLUGIN_DEST}
	doins ${WORKDIR}/${P}.py
}

pkg_postinst() {
	python_mod_compile ${PLUGIN_DEST}/${P}.py
}

pkg_postrm() {
	python_mod_cleanup ${PLUGIN_DEST}
}
