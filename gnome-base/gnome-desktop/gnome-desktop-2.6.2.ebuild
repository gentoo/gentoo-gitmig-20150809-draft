# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.6.2.ebuild,v 1.3 2004/07/28 02:55:13 tgall Exp $

inherit gnome2 eutils

DESCRIPTION="Libraries for the gnome desktop that is not part of the UI"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 FDL-1.1 LGPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ppc64"

RDEPEND=">=x11-libs/gtk+-2.1.2
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=x11-libs/startup-notification-0.5
	!gnome-base/gnome-core"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	sys-devel/autoconf"

DOCS="AUTHORS ChangeLog COPYING* README INSTALL NEWS HACKING"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Set vendor info
	sed -i 's:GNOME.Org:Gentoo Linux:' configure.in \
	|| die "sed failed (1)"

	WANT_AUTOCONF_2_5=1 autoconf || die

	# Fix bug 16853 by building gnome-about with IEEE to prevent
	# floating point exceptions on alpha
	if use alpha; then
		sed -i '/^CFLAGS/s/$/ -mieee/' ${S}/gnome-about/Makefile.in \
		|| die "sed failed (2)"
	fi
}
