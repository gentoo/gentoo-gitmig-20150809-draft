# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.10.1.ebuild,v 1.8 2005/08/22 23:40:03 agriffis Exp $

inherit gnome2 eutils

DESCRIPTION="Libraries for the gnome desktop that is not part of the UI"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.1.2
	>=dev-libs/glib-2.6
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=x11-libs/startup-notification-0.5
	!gnome-base/gnome-core"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog README NEWS HACKING"

G2CONF="$G2CONF --with-gnome-distributor=Gentoo"

src_unpack() {

	unpack ${A}
	cd ${S}

	# Fix bug 16853 by building gnome-about with IEEE to prevent
	# floating point exceptions on alpha
	if use alpha; then
		sed -i '/^CFLAGS/s/$/ -mieee/' ${S}/gnome-about/Makefile.in \
		|| die "sed failed (2)"
	fi

}
USE_DESTDIR="1"
