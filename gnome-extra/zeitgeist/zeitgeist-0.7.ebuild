# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist/zeitgeist-0.7.ebuild,v 1.2 2011/03/05 01:52:25 signals Exp $

EAPI=3
PYTHON_DEPEND="2"
inherit autotools eutils python

EXT_VER=0.0.6
DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="http://launchpad.net/zeitgeist"
SRC_URI="http://launchpad.net/zeitgeist/${PV}/${PV}/+download/${P}.tar.gz
	http://launchpad.net/zeitgeist-extensions/trunk/${EXT_VER}/+download/zeitgeist-extensions-${EXT_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fts"

RDEPEND="media-libs/raptor:2
	dev-python/rdflib
	dev-python/dbus-python
	dev-python/pyxdg
	fts? ( dev-libs/xapian-bindings[python] )"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-rdfpipe.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	insinto /usr/share/zeitgeist/_zeitgeist/engine/extensions
	if use fts; then
		doins "${WORKDIR}"/zeitgeist-extensions-${EXT_VER}/fts/fts.py
	fi
}
