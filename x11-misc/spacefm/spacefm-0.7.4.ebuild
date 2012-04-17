# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/spacefm/spacefm-0.7.4.ebuild,v 1.4 2012/04/17 14:32:51 ssuominen Exp $

EAPI=4
inherit fdo-mime

DESCRIPTION="a multi-panel tabbed file manager"
HOMEPAGE="http://spacefm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kernel_linux"

RDEPEND="dev-libs/glib:2
	dev-util/desktop-file-utils
	sys-apps/dbus
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/startup-notification
	x11-misc/shared-mime-info
	!kernel_linux? ( virtual/fam )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--htmldir=/usr/share/doc/${PF}/html \
		--disable-hal \
		$(use_enable kernel_linux inotify)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	einfo ""
	elog "To mount as non-root user you need:"
	elog "  sys-fs/udisks:0"
	elog "To perform as root functionality you need one of the following:"
	elog "  x11-misc/ktsuss"
	elog "  x11-libs/gksu"
	elog "  kde-base/kdesu"
	elog "Other optional dependencies:"
	elog "  sys-process/lsof (device processes)"
	elog "  virtual/eject (eject media)"
	einfo""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
