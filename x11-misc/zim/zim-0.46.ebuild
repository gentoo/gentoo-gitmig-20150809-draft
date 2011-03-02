# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/zim/zim-0.46.ebuild,v 1.3 2011/03/02 19:22:25 signals Exp $

PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="2:2.5"

EAPI="3"

inherit eutils virtualx fdo-mime distutils

DESCRIPTION="A desktop wiki"
HOMEPAGE="http://zim-wiki.org/"
SRC_URI="http://zim-wiki.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz latex screenshot spell test"

RDEPEND="|| ( >=dev-lang/python-2.6 dev-python/simplejson )
	dev-python/pygobject
	dev-python/pygtk
	x11-libs/gtk+:2
	x11-misc/xdg-utils
	graphviz? ( media-gfx/graphviz )
	latex? ( virtual/latex-base app-text/dvipng )
	screenshot? ( media-gfx/scrot )
	spell? ( dev-python/gtkspell-python )"

DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-disable-updates.patch"
	# remove unneeded variables
	sed -i "/^assert/s:^:#:g" "${S}"/zim/__init__.py
}

src_test() {
	export maketype="$(PYTHON)"
	virtualmake test.py || die "src_test failed"
}

src_install () {
	doicon data/${PN}.png || die "doicon failed"
	distutils_src_install
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	xdg-icon-resource install --context mimetypes --size 64 \
		"${ROOT}/usr/share/pixmaps/zim.png" \
		application-x-zim-notebook || die "xdg-icon-resource install failed"
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
	xdg-icon-resource uninstall --context mimetypes --size 64 \
		application-x-zim-notebook || die "xdg-icon-resource uninstall failed"
}
