# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/thunar/thunar-1.1.4.ebuild,v 1.1 2010/11/04 14:11:06 ssuominen Exp $

EAPI=3
inherit virtualx xfconf

MY_P=${P/t/T}

DESCRIPTION="File manager for Xfce4"
HOMEPAGE="http://thunar.xfce.org/"
SRC_URI="mirror://xfce/src/xfce/${PN}/1.1/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug exif libnotify pcre startup-notification test +xfce_plugins_trash udev"

COMMON_DEPEND=">=xfce-base/exo-0.5.3
	>=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfce4ui-4.7.1
	>=dev-lang/perl-5.6
	dbus? ( dev-libs/dbus-glib )
	exif? ( >=media-libs/libexif-0.6.19 )
	libnotify? ( x11-libs/libnotify )
	pcre? ( >=dev-libs/libpcre-6 )
	startup-notification? ( x11-libs/startup-notification )
	xfce_plugins_trash? ( dev-libs/dbus-glib
		>=xfce-base/xfce4-panel-4.3.90 )
	udev? ( >=sys-fs/udev-145[extras] )"
RDEPEND="${COMMON_DEPEND}
	>=x11-misc/shared-mime-info-0.80
	>=dev-util/desktop-file-utils-0.17
	udev? ( >=gnome-base/gvfs-1.6.3[gdu,udev] )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable startup-notification)
		$(use_enable udev gudev)
		$(use_enable libnotify notifications)
		$(use_enable debug)
		$(use_enable exif)
		$(use_enable pcre)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	if use xfce_plugins_trash; then
		XFCONF+=( --enable-dbus )
	else
		XFCONF+=( --disable-tpa-plugin )
	fi

	DOCS="AUTHORS ChangeLog FAQ HACKING NEWS README THANKS TODO"
}

src_test() {
	Xemake check || die
}
