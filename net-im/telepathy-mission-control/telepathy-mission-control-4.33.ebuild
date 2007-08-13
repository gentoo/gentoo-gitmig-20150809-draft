# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-mission-control/telepathy-mission-control-4.33.ebuild,v 1.1 2007/08/13 15:19:45 coldwind Exp $

DESCRIPTION="Nokia's implementation of a Telepathy Mission Control"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Mission_Control"
SRC_URI="mirror://sourceforge/mission-control/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=net-libs/libtelepathy-0.0.54
	>=dev-libs/dbus-glib-0.51
	>=gnome-base/gconf-2
	>=dev-util/pkgconfig-0.12.0
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	doc? ( >=dev-util/gtk-doc-1.3 )"

src_compile() {
	econf $(use_enable doc gtk-doc) \
		--enable-server \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
