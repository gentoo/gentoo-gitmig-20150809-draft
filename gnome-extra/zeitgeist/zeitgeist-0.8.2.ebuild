# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist/zeitgeist-0.8.2.ebuild,v 1.1 2012/01/31 17:00:00 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils python versionator

DIR_PV=$(get_version_component_range 1-2)
EXT_VER=0.0.13

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="http://launchpad.net/zeitgeist"
SRC_URI="
	http://launchpad.net/zeitgeist/${DIR_PV}/${PV}/+download/${P}.tar.gz
	http://launchpad.net/zeitgeist-extensions/trunk/fts-${EXT_VER}/+download/zeitgeist-extensions-${EXT_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fts"

RDEPEND="
	dev-python/dbus-python
	dev-python/pyxdg
	dev-python/rdflib
	media-libs/raptor:2
	fts? ( dev-libs/xapian-bindings[python] )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.7.1-no-rdfpipe.patch )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	autotools-utils_src_install
	if use fts; then
		insinto /usr/share/zeitgeist/_zeitgeist/engine/extensions
		doins "${WORKDIR}"/zeitgeist-extensions-${EXT_VER}/fts/fts.py
	fi
	python_convert_shebangs -r 2 "${ED}"
}
