# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/spacefm/spacefm-0.6.2.ebuild,v 1.1 2012/02/07 03:26:04 xmw Exp $

EAPI=4
inherit fdo-mime

DESCRIPTION="a multi-panel tabbed file manager"
HOMEPAGE="http://spacefm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

# Internal copy of xfce-base/exo is LGPL-2 at src/exo/
LICENSE="GPL-2 IgnorantGuru LGPL-2"
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
		|| ( x11-libs/gksu kde-base/kdesu x11-misc/ktsuss ) )"
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
