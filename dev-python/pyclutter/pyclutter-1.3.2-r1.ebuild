# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclutter/pyclutter-1.3.2-r1.ebuild,v 1.1 2011/02/11 21:08:58 nirbheek Exp $

EAPI="2"
PYTHON_DEPEND="2:2.6"
CLUTTER_LA_PUNT="yes"

inherit eutils python clutter

DESCRIPTION="Python bindings for Clutter"

KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

SLOT="1.0"
RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.8.0
	>=dev-python/pygobject-2.21.3
	>=dev-python/pycairo-1.0.2
	>=media-libs/clutter-1.4.0:${SLOT}"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )"
EXAMPLES="examples/{*.py,*.png}"

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
	python_mod_optimize $(python_get_sitedir)/clutter
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup /usr/lib*/python*/site-packages/clutter
}
