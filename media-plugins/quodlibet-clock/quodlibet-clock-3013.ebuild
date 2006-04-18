# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-clock/quodlibet-clock-3013.ebuild,v 1.1 2006/04/18 16:28:45 tcort Exp $

inherit python

DESCRIPTION="Alarm clock plugin for Quod Libet to wake you up with loud music."
HOMEPAGE="http://www.sacredchao.net/quodlibet/file/trunk/plugins/clock.py"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-sound/quodlibet-0.19.1"

PLUGIN_DEST="${DESTDIR}/usr/share/quodlibet/plugins"

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
