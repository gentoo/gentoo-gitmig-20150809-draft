# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclutter/pyclutter-1.0.2.ebuild,v 1.1 2010/06/26 02:34:44 nirbheek Exp $

EAPI="2"

inherit eutils python clutter

DESCRIPTION="Python bindings for Clutter"

KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

SLOT="1.0"
RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.8.0
	>=dev-python/pycairo-1.0.2
	>=media-libs/clutter-1.2.0:${SLOT}"
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
