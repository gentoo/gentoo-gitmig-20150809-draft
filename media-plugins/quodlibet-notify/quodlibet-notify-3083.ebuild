# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-notify/quodlibet-notify-3083.ebuild,v 1.1 2006/04/30 05:39:16 tcort Exp $

inherit python

DESCRIPTION="Quod Libet plugin that displays song change notification using libnotify."
HOMEPAGE="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/notify.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.19.1
	x11-libs/libnotify"

PLUGIN_DEST="/usr/share/quodlibet/plugins"

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
