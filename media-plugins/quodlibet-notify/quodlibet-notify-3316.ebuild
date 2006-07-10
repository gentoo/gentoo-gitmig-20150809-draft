# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-notify/quodlibet-notify-3316.ebuild,v 1.3 2006/07/10 13:04:06 tcort Exp $

inherit python

DESCRIPTION="Quod Libet plugin that displays song change notification using libnotify."
HOMEPAGE="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/events/notify.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.21
	x11-libs/libnotify"

PLUGIN_DEST="/usr/share/quodlibet/plugins/events"

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
