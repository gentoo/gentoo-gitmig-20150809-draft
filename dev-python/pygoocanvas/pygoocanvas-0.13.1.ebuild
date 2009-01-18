# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoocanvas/pygoocanvas-0.13.1.ebuild,v 1.1 2009/01/18 21:25:43 eva Exp $

GCONF_DEBUG="no"

inherit gnome2 python

DESCRIPTION="GooCanvas python bindings"
HOMEPAGE="http://live.gnome.org/PyGoocanvas"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=dev-python/pygobject-2.11.3
	>=dev-python/pygtk-2.10.4
	>=dev-python/pycairo-1.4
	>=x11-libs/goocanvas-0.13"
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

pkg_postinst() {
	python_need_rebuild
}
