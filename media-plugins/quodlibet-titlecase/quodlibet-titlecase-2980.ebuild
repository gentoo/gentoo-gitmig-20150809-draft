# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-titlecase/quodlibet-titlecase-2980.ebuild,v 1.3 2006/04/22 15:24:33 tcort Exp $

inherit python

DESCRIPTION="Quod Libet plugin to Title-case tag values in the editor."
HOMEPAGE="http://www.sacredchao.net/quodlibet/file/trunk/plugins/editing/titlecase.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.19.1"

PLUGIN_DEST="${D}/usr/share/quodlibet/plugins/editing"

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
