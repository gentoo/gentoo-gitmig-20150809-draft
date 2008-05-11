# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xfmedia/xfmedia-0.9.2-r2.ebuild,v 1.1 2008/05/11 15:43:32 drac Exp $

inherit eutils fdo-mime gnome2-utils

DESCRIPTION="a GTK+ based xine-lib frontend designed to be used with Xfce4 desktop enviroment"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus debug startup-notification taglib"

RDEPEND="x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libXtst
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-4.2
	>=xfce-base/libxfcegui4-4.2
	media-libs/xine-lib
	xfce-extra/exo
	startup-notification? ( x11-libs/startup-notification )
	dbus? ( dev-libs/dbus-glib )
	taglib? ( media-libs/taglib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${FILESDIR}"/${PV}
}

src_compile() {
	econf --disable-dependency-tracking $(use_with taglib) \
		$(use_enable dbus) $(use_enable debug) \
		$(use_enable startup-notification)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README* TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
