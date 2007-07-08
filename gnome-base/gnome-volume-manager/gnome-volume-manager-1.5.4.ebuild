# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-volume-manager/gnome-volume-manager-1.5.4.ebuild,v 1.11 2007/07/08 05:07:11 mr_bones_ Exp $

inherit eutils gnome2

DESCRIPTION="Daemon that enforces volume-related policies"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~cardoe/files/${PN}-1.3.3-reconnect_dbus.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc crypt"

RDEPEND=">=x11-libs/gtk+-2.6
	>=sys-apps/dbus-0.31
	>=sys-apps/hal-0.5.0
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	sys-apps/pmount"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.27.2"

DOCS="AUTHORS ChangeLog README HACKING NEWS TODO"
USE_DESTDIR="1"

pkg_setup() {
	G2CONF="--with-eject-command=/usr/bin/eject"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	#epatch ${FILESDIR}/gnome-volume-manager-1.3.2-set_defaults.patch
	epatch ${DISTDIR}/gnome-volume-manager-1.3.3-reconnect_dbus.patch.bz2
	# Doesn't apply to current cvs.  Must look at leater.
	#epatch ${FILESDIR}/gnome-volume-manager-1.3.3-pmount_crypt.patch
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "To start the gnome-volume-manager daemon you need to configure"
	elog "it through it's preferences capplet. Also the HAL daemon (hald)"
	elog "needs to be running or it will shut down."
}
