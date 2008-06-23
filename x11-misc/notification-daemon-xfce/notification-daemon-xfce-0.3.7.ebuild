# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon-xfce/notification-daemon-xfce-0.3.7.ebuild,v 1.2 2008/06/23 02:05:30 drac Exp $

EAPI=1

inherit autotools

DESCRIPTION="Port of notification daemon for Xfce Desktop Environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/notification-daemon-xfce"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="debug +xfce"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfcegui4-4.3.90
	>=xfce-base/libxfce4util-4.3.90
	>=xfce-base/xfce-mcs-manager-4.2.2
	>=x11-libs/libsexy-0.1.3
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	!x11-misc/notification-daemon"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${FILESDIR}"/${PV}
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking \
		--enable-gradient-look \
		$(use_enable debug) \
		$(use_enable xfce mcs-plugin)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
