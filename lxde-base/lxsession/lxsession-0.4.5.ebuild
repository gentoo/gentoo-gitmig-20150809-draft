# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession/lxsession-0.4.5.ebuild,v 1.2 2011/01/26 20:13:12 hwoarang Exp $

EAPI="2"

DESCRIPTION="LXDE session manager (lite version)"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
SLOT="0"
IUSE="dbus nls udev"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	sys-apps/dbus
	>=lxde-base/lxde-common-0.5.0
	udev? ( sys-power/upower )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable dbus) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
