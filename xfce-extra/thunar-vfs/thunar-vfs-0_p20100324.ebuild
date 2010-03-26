# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-vfs/thunar-vfs-0_p20100324.ebuild,v 1.4 2010/03/26 09:19:56 ssuominen Exp $

EAPI=2
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Separate package for (old) Thunar VFS libraries"
HOMEPAGE="http://git.xfce.org/xfce/thunar-vfs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus debug doc gnome hal startup-notification"

RDEPEND=">=xfce-base/exo-0.5.1
	>=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=media-libs/libpng-1.2
	>=media-libs/freetype-2
	>=media-libs/jpeg-6b:0
	dbus? ( >=dev-libs/dbus-glib-0.34 )
	gnome? ( >=gnome-base/gconf-2 )
	hal? ( >=dev-libs/dbus-glib-0.34
		sys-apps/hal )
	startup-notification? ( >=x11-libs/startup-notification-0.4 )
	!<xfce-base/thunar-1.1.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	dev-lang/perl
	dev-util/gtk-doc-am
	doc? ( dev-libs/libxslt )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

	XFCONF="--enable-maintainer-mode
		--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable gnome gnome-thumbnailers)
		$(use_enable startup-notification)
		$(use_enable doc xsltproc)
		$(use_enable debug)
		--with-html-dir=/usr/share/doc/${PF}/html"

	if use hal; then
		XFCONF="${XFCONF} --enable-dbus --with-volume-manager=hal"
	else
		XFCONF="${XFCONF} --with-volume-manager=none"
	fi

	PATCHES=( "${FILESDIR}/${PN}-libpng14.patch" )
}

src_prepare() {
	sed -i \
		-e "/^docdir/s:=.*:= /usr/share/doc/${PF}:" \
		docs/Makefile.am || die

	xfconf_src_prepare
}
