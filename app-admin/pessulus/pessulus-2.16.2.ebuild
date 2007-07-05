# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pessulus/pessulus-2.16.2.ebuild,v 1.11 2007/07/05 15:43:53 uberlord Exp $

inherit gnome2 multilib python

DESCRIPTION="lockdown editor for GNOME"
HOMEPAGE="http://live.gnome.org/Pessulus"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-python/pygtk-2.6.0
	>=dev-python/gnome-python-2.6.0
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

src_unpack() {
	gnome2_src_unpack
	intltoolize --force
	# Fix tests. Remove this echo when upstream fixes it. Problem comes from
	# intltool-0.35.5 that is more strict about this, and we intltoolize it to that version
	echo "data/pessulus.desktop.in" >> "${S}/po/POTFILES.skip"
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages/Pessulus
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
