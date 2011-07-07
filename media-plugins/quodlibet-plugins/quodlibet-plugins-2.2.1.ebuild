# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-plugins/quodlibet-plugins-2.2.1.ebuild,v 1.4 2011/07/07 15:28:23 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="Plugins for Quod Libet and Ex Falso"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="!media-plugins/quodlibet-titlecase
	!media-plugins/quodlibet-html
	!media-plugins/quodlibet-cddb
	!media-plugins/quodlibet-clock
	!media-plugins/quodlibet-notify
	!media-plugins/quodlibet-resub
	!media-plugins/quodlibet-albumart
	!media-plugins/quodlibet-jep118
	!media-plugins/quodlibet-reset
	!media-plugins/quodlibet-importexport
	!media-plugins/quodlibet-autorating
	!media-plugins/quodlibet-trayicon
	!media-plugins/quodlibet-wikipedia
	!media-plugins/quodlibet-browsefolders"
RDEPEND="${DEPEND}
	>=media-sound/quodlibet-2.2.1"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	rm -f README || die
}

src_install() {
	insinto "$(python_get_sitedir)"/quodlibet/plugins
	doins -r * || die
}

pkg_postinst() {
	python_mod_optimize quodlibet/plugins
}

pkg_postrm() {
	python_mod_cleanup quodlibet/plugins
}
