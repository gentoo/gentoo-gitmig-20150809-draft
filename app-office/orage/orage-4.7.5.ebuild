# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/orage/orage-4.7.5.ebuild,v 1.6 2010/12/27 12:44:24 maekke Exp $

EAPI=3
EAUTORECONF=yes
inherit flag-o-matic xfconf

DESCRIPTION="Xfce's calendar suite (with panel plug-in)"
HOMEPAGE="http://www.xfce.org/projects/orage/"
SRC_URI="mirror://xfce/src/apps/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
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

S=${WORKDIR}/${P}.16

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-asneeded.patch )

	XFCONF=(
		--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable libnotify)
		$(use_with berkdb bdb4)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_configure() {
	append-flags -I/usr/include/libical
	xfconf_src_configure
}
