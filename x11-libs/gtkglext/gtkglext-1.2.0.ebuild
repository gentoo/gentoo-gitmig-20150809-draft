# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-1.2.0.ebuild,v 1.15 2008/11/17 18:36:58 dang Exp $

inherit gnome2 autotools

DESCRIPTION="GL extensions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.10 )
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog* INSTALL NEWS README* TODO"

pkg_setup() {
	if ! built_with_use x11-libs/pango X; then
		eerror "Please re-emerge x11-libs/pango with the X USE flag set"
		die "needs pango with the X flag set"
	fi
}
