# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/spacefm/spacefm-0.6.3.ebuild,v 1.1 2012/02/09 20:12:16 xmw Exp $

EAPI=4
inherit fdo-mime

DESCRIPTION="a multi-panel tabbed file manager"
HOMEPAGE="http://spacefm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fam gtk kde kernel_linux su udev"

COMMON_DEPEND=">=dev-libs/glib-2
	dev-util/desktop-file-utils
	sys-apps/dbus
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/startup-notification"
RDEPEND="${COMMON_DEPEND}
	virtual/eject
	virtual/freedesktop-icon-theme
	x11-misc/shared-mime-info
	!kernel_linux? ( fam? ( virtual/fam ) )
	udev? ( sys-fs/udisks
		sys-process/lsof )
	su? (
		gtk? ( x11-libs/gksu )
		kde? ( kde-base/kdesu )
		|| ( x11-misc/ktsuss x11-libs/gksu kde-base/kdesu ) )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-hal \
		$(use_enable kernel_linux inotify)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
