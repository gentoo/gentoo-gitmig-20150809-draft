# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-2.10.1.ebuild,v 1.11 2006/09/05 02:10:47 kumba Exp $

inherit gnome2 virtualx

DESCRIPTION="User Interface part of libbonobo"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="doc static"

RDEPEND=">=gnome-base/libgnomecanvas-1.116
	>=gnome-base/libbonobo-2.3.3
	>=gnome-base/libgnome-1.116
	>=dev-libs/libxml2-2.4.20
	>=gnome-base/gconf-1.1.9
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-1.99.11"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"


pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_test() {
	Xmake check || die
}
