# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.4.2-r1.ebuild,v 1.1 2007/12/03 16:36:09 drac Exp $

inherit eutils xfce44

XFCE_VERSION=4.4.2
xfce44

DESCRIPTION="Collection of utils"
HOMEPAGE="http://www.xfce.org/projects/xfce-utils"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus debug"

RDEPEND="x11-apps/xrdb
	x11-libs/libX11
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable dbus) --enable-gdm --with-vendor-info=Gentoo"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_core_package

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-nolisten-tcp.patch
}

src_install() {
	xfce44_src_install
	insinto /usr/share/xfce4
	doins "${FILESDIR}"/Gentoo
}
