# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-1.1.ebuild,v 1.1 2011/10/19 19:52:40 tetromino Exp $

EAPI="3"

PYTHON_DEPEND="2"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="xz"
GNOME2_LA_PUNT="yes"
inherit eutils gnome2 python

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="|| ( dev-python/pygobject:3
		>=dev-python/pygobject-2.28.2:2[introspection] )
	>=gnome-base/nautilus-2.32[introspection]"
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
	if [[ "${P}" != "${PF}" ]]; then
		mv "${D}"/usr/share/doc/{${P}/*,${PF}} || die
		rm -rf "${D}"/usr/share/doc/${P}
	fi
}
