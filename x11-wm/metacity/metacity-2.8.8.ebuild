# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.8.8.ebuild,v 1.7 2005/04/02 03:16:58 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome default windowmanager"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="xinerama"

# not parallel-safe; see bug #14405
MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND="virtual/x11
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2.0-r1
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.7
	!x11-misc/expocity"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"

# Compositor is too unreliable
G2CONF="${G2CONF} $(use_enable xinerama) --disable-compositor"

DOCS="AUTHORS ChangeLog HACKING NEWS README *txt"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Fix the logout shortcut problems, by moving the keybindings
	# into here, from control-center, fixes bug #52034
	epatch ${FILESDIR}/metacity-2-logout.patch

}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Metacity & Xorg X11 with composite enabled may cause unwanted border effects"

}
