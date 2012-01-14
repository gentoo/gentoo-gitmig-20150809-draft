# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclutter/pyclutter-1.3.2-r2.ebuild,v 1.5 2012/01/14 16:39:30 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
CLUTTER_LA_PUNT="yes"

inherit eutils python clutter

DESCRIPTION="Python bindings for Clutter"

KEYWORDS="amd64 x86"
IUSE="doc examples"

SLOT="1.0"
RDEPEND="
	>=dev-python/pygtk-2.8.0
	>=dev-python/pygobject-2.21.3:2
	>=dev-python/pycairo-1.0.2
	>=media-libs/clutter-1.4.0:${SLOT}"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )"
EXAMPLES="examples/{*.py,*.png}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs --recursive 2 examples codegen
	default_src_prepare
}

src_configure() {
	ln -sf $(type -P true) py-compile
	local myconf="
		--with-clutterx11=yes
		--with-clutterglx=yes
		$(use_enable doc docs)"

	econf ${myconf}
}

src_install() {
	# FIXME: Parallel make failure in emake install
	MAKEOPTS="-j1" clutter_src_install
}

pkg_postinst() {
	python_mod_optimize clutter
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup clutter
}
