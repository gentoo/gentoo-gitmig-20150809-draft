# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/spacefm/spacefm-0.6.0.ebuild,v 1.1 2012/01/31 22:33:46 xmw Exp $

EAPI=4

inherit fdo-mime

DESCRIPTION="multi-paned tabbed file manager"
HOMEPAGE="http://spacefm.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${P}.tar.xz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="fam gnome kde udev"

COMMON_DEPEND="dev-libs/glib:2
	dev-util/desktop-file-utils
	sys-apps/dbus
	x11-libs/gtk+:2
	x11-libs/startup-notification"
RDEPEND="${COMMON_DEPEND}
	virtual/eject
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
	x11-misc/shared-mime-info
	fam? ( virtual/fam )
	gnome? ( x11-libs/gksu )
	kde? ( kde-base/kdesu )
	udev? ( sys-fs/udisks )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-hal \
		$(use_enable !fam inotify)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
