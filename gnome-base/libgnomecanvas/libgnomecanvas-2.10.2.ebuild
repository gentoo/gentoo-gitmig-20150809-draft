# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-2.10.2.ebuild,v 1.3 2005/08/25 19:26:34 agriffis Exp $

inherit virtualx gnome2

DESCRIPTION="The Gnome 2 Canvas library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="doc static"

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2.0.3
	>=x11-libs/pango-1.0.1
	>=media-libs/libart_lgpl-2.3.8"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"
G2CONF="${G2CONF} $(use_enable static)"

src_test() {
	Xmake check
}
