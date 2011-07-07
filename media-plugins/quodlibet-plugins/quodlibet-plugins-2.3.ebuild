# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-plugins/quodlibet-plugins-2.3.ebuild,v 1.2 2011/07/07 15:28:23 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="Plugins for Quod Libet and Ex Falso"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/quodlibet-${PV}"
DEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
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
