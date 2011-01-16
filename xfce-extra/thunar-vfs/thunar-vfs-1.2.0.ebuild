# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-vfs/thunar-vfs-1.2.0.ebuild,v 1.2 2011/01/16 18:52:35 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce's filesystem libraries (deprecated: don't use this for future development)"
HOMEPAGE="http://git.xfce.org/xfce/thunar-vfs/"
SRC_URI="mirror://xfce/src/xfce/${PN}/1.2/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug gnome startup-notification"

RDEPEND=">=xfce-base/exo-0.6
	>=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.8
	>=media-libs/libpng-1.4
	>=media-libs/freetype-2
	virtual/fam
	virtual/jpeg
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	gnome? ( >=gnome-base/gconf-2 )
	startup-notification? ( >=x11-libs/startup-notification-0.4 )
	!<xfce-base/thunar-1.1.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	dev-lang/perl"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable gnome gnome-thumbnailers)
		$(use_enable startup-notification)
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		--with-volume-manager=none
		)

	DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"
}

src_install() {
	xfconf_src_install \
		docdir="${EPREFIX}"/usr/share/doc/${PF}
}
