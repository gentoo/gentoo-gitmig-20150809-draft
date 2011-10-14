# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-1.0.ebuild,v 1.1 2011/10/14 00:40:24 pva Exp $

EAPI="3"

PYTHON_DEPEND="2"
GCONF_DEBUG="no"
inherit eutils gnome2 python autotools

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/pygobject-2.28.2
	>=gnome-base/nautilus-2.32"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.9 )"

DOCS="AUTHORS ChangeLog NEWS README"
G2CONF="--docdir=${EPREFIX}/usr/share/doc/${PF}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	gnome2_src_install
	mv "${D}"/usr/share/doc/{${PN}/*,${PF}} || die
	rm -rf "${D}"/usr/share/doc/${PN}
	find "${ED}" -name '*.la' -exec rm -f {} +
}
