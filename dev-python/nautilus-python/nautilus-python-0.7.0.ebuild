# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-0.7.0.ebuild,v 1.1 2011/02/03 07:37:09 pva Exp $

EAPI="3"

inherit eutils gnome2

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DOCS="AUTHORS ChangeLog NEWS"
G2CONF="--docdir=${EPREFIX}/usr/share/doc/${PF}"

# FIXME: dev-python/gnome-python-base is not required actually, but configure script
# checks for it for some unknown reason
RDEPEND="dev-python/pygtk
	dev-python/pygobject
	gnome-base/nautilus"
DEPEND="${RDEPEND}
	dev-python/gnome-python-base
	doc? ( >=dev-util/gtk-doc-1.9 )"

src_install() {
	gnome2_src_install
	mv "${D}"/usr/share/doc/{${PN}/*,${PF}} || die
	rm -rf "${D}"/usr/share/doc/${PN}
	prepalldocs
}
