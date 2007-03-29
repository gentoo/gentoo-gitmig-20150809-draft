# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-autorating/quodlibet-autorating-3316.ebuild,v 1.2 2007/03/29 08:23:14 corsair Exp $

inherit python

DESCRIPTION="Rate songs automatically when they are played or skipped."
HOMEPAGE="http://www.sacredchao.net/quodlibet/file/trunk/plugins/events/autorating.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.21"

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
