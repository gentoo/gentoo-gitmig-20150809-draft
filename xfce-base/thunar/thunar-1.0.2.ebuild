# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/thunar/thunar-1.0.2.ebuild,v 1.13 2011/02/07 19:06:57 ssuominen Exp $

EAPI=3
MY_P=${P/t/T}
inherit virtualx xfconf

DESCRIPTION="File manager for Xfce4"
HOMEPAGE="http://thunar.xfce.org"
SRC_URI="mirror://xfce/src/xfce/${PN}/1.0/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug doc exif gnome hal pcre startup-notification +xfce_plugins_trash"

RDEPEND=">=dev-lang/perl-5.6
	>=dev-libs/glib-2.6:2
	>=dev-util/desktop-file-utils-0.14
	>=media-libs/freetype-2
	virtual/jpeg
	>=media-libs/libpng-1.4
	virtual/fam
	>=x11-libs/gtk+-2.6:2
	x11-libs/libSM
	>=x11-misc/shared-mime-info-0.20
	>=xfce-base/exo-0.3.92[hal?]
	<xfce-base/exo-0.5
	>=xfce-base/libxfce4util-4.6
	dbus? ( dev-libs/dbus-glib )
	exif? ( >=media-libs/libexif-0.6 )
	hal? ( dev-libs/dbus-glib
		sys-apps/hal )
	gnome? ( gnome-base/gconf )
	pcre? ( >=dev-libs/libpcre-6 )
	startup-notification? ( x11-libs/startup-notification )
	xfce_plugins_trash? ( dev-libs/dbus-glib
		>=xfce-base/xfce4-panel-4.6 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( dev-libs/libxslt )"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable gnome gnome-thumbnailers)
		$(use_enable startup-notification)
		$(use_enable doc xsltproc)
		$(use_enable exif)
		$(use_enable pcre)
		$(use_enable debug)"

	if use hal; then
		XFCONF="${XFCONF} --enable-dbus --with-volume-manager=hal"
	else
		XFCONF="${XFCONF} --with-volume-manager=none"
	fi

	if use xfce_plugins_trash; then
		XFCONF="${XFCONF} --enable-dbus"
	else
		XFCONF="${XFCONF} --disable-tpa-plugin"
	fi
	DOCS="AUTHORS ChangeLog FAQ HACKING NEWS README THANKS TODO"
}

src_test() {
	Xemake check || die
}
