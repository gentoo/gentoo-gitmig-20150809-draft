# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-2.20.1.1.ebuild,v 1.11 2010/08/03 01:19:58 jer Exp $

inherit virtualx gnome2

DESCRIPTION="The Gnome 2 Canvas library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc"

# gail dep at 1.19.6 to ensure both gail and libgnomecanvas aren't providing GailCanvas (got moved to here with gail-1.19.6)
RDEPEND=">=x11-libs/gtk+-2.13.0
	>=media-libs/libart_lgpl-2.3.8
	>=x11-libs/pango-1.0.1
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.18
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

src_test() {
	Xmake check || die "Test phase failed"
}
