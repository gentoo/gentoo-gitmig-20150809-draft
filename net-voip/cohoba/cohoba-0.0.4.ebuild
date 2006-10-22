# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/cohoba/cohoba-0.0.4.ebuild,v 1.3 2006/10/22 18:41:19 peper Exp $

inherit eutils

DESCRIPTION="Gnome UI for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/cohoba/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/gnome-python-desktop
	>=sys-apps/dbus-0.61
	x11-themes/gnome-icon-theme
	x11-themes/gnome-themes"
RDEPEND="${DEPEND}
	dev-python/telepathy-python
	gnome-base/control-center"

pkg_setup() {
	if ! built_with_use sys-apps/dbus python; then
		eerror "you need to build dbus with USE=python"
		die "dbus needs python bindings"
	fi

}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "To run cohoba use:"
	elog "$ /usr/lib/cohoba/cohoba-applet -w"
	elog "For non-gnome, gnome-settings-daemon needs to be running:"
	elog "$ /usr/libexec/gnome-settings-daemon"
}
