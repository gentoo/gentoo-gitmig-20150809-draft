# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-1.2.0.ebuild,v 1.9 2007/03/28 10:26:27 armin76 Exp $

inherit gnome2 autotools

DESCRIPTION="GL extensions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
LICENSE="GPL-2 LGPL-2.1"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
IUSE="doc"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1
	virtual/glu
	virtual/opengl"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.10 )
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS README* TODO"
