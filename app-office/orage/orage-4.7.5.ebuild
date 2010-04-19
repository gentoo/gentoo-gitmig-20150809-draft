# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/orage/orage-4.7.5.ebuild,v 1.2 2010/04/19 15:40:11 ssuominen Exp $

EAPI=2
EAUTORECONF=yes
inherit flag-o-matic xfconf

DESCRIPTION="Calendar suite for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/orage/"
SRC_URI="mirror://xfce/src/apps/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="berkdb dbus debug libnotify"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfce4-panel-4.6
	>=dev-libs/libical-0.43
	berkdb? ( >=sys-libs/db-4 )
	libnotify? ( x11-libs/libnotify )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

# source of 4.7.5 unpacks into 4.7.5.16.
S=${WORKDIR}/${P}.16

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable libnotify)
		$(use_with berkdb bdb4)
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	PATCHES=( "${FILESDIR}/${P}-asneeded.patch" )
}

src_configure() {
	append-flags -I/usr/include/libical
	xfconf_src_configure
}
