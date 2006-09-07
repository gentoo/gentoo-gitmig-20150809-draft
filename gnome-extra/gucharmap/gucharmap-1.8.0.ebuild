# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-1.8.0.ebuild,v 1.1 2006/09/07 04:09:01 dang Exp $

inherit gnome2

DESCRIPTION="Unicode character map viewer"
HOMEPAGE="http://gucharmap.sourceforge.net/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cjk gnome"

RDEPEND=">=dev-libs/glib-2.3
	>=x11-libs/pango-1.2.1
	>=x11-libs/gtk+-2.6
	!gnome? ( dev-libs/popt )
	gnome?	(
				>=gnome-base/libgnome-2.2
				>=gnome-base/libgnomeui-2.2
			)
	!<gnome-extra/gnome-utils-2.3"

DEPEND="${RDEPEND}
	  app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper \
		$(use_enable gnome) \
		$(use_enable cjk unihan)"
}

src_unpack() {
	gnome2_src_unpack

	# fix gtk-update-icon-cache generation
	sed -i -e 's:gtk-update-icon-cache:true:' ./pixmaps/Makefile.in
}
