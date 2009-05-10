# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoocanvas/pygoocanvas-0.14.1.ebuild,v 1.2 2009/05/10 18:40:26 ford_prefect Exp $

GCONF_DEBUG="no"

inherit gnome2 python

DESCRIPTION="GooCanvas python bindings"
HOMEPAGE="http://live.gnome.org/PyGoocanvas"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

RDEPEND=">=dev-python/pygobject-2.11.3
	>=dev-python/pygtk-2.10.4
	>=dev-python/pycairo-1.8
	>=x11-libs/goocanvas-0.14"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (
		dev-libs/libxslt
		dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable doc docs)"
}

src_prepare() {
	sed -e 's/^\(SUBDIRS =.*\)demo\(.*\)$/\1\2/' \
		-i Makefile.am Makefile.in || die "sed 1 failed"
}

src_install() {
	gnome2_src_install

	if use examples; then
		rm demo/Makefile*
		cp -R demo "${D}"/usr/share/doc/${PF}
	fi
}

pkg_postinst() {
	python_need_rebuild
}
