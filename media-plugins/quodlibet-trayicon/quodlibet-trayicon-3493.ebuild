# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-trayicon/quodlibet-trayicon-3493.ebuild,v 1.5 2007/03/29 08:22:03 corsair Exp $

inherit python eutils

DESCRIPTION="Tray icon for Quod Libet."
HOMEPAGE="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/events/trayicon.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.22"

PLUGIN_DEST="/usr/share/quodlibet/plugins/events"

pkg_setup() {
	if ! built_with_use media-sound/quodlibet trayicon ; then
		eerror "media-sound/quodlibet is missing trayicon support. Please add"
		eerror "'trayicon' to your USE flags, and re-emerge media-sound/quodlibet."
		die "media-sound/quodlibet needs trayicon support"
	fi
}

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
