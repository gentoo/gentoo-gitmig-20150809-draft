# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-1.0.6-r2.ebuild,v 1.2 2005/04/04 22:17:53 foser Exp $

inherit gnome2

DESCRIPTION="GL extensions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
LICENSE="GPL-2 LGPL-2.1"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
IUSE="doc"
KEYWORDS="x86 ~sparc ~alpha ~ppc ~ia64 ~amd64"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1
	virtual/glu
	virtual/opengl"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.10 )
	>=x11-base/opengl-update-1.5
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS README* TODO"

# gtkglext doesn't build with some (faulty) nvidia drivers headers
# this makes it always switch to x11 headers during install
# foser <foser@gentoo.org>

pkg_setup () {

	# Set up X11 implementation
	X11_IMPLEM_P="$(portageq best_version "${ROOT}" virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"
	einfo "X11 implementation is ${X11_IMPLEM}."

	GL_IMPLEM=$(opengl-update --get-implementation)
	opengl-update ${X11_IMPLEM}

}

pkg_postinst () {

	opengl-update ${GL_IMPLEM}

}
