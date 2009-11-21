# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obex-data-server/obex-data-server-0.3.ebuild,v 1.7 2009/11/21 15:16:19 armin76 Exp $

EAPI=1

DESCRIPTION="a DBus service providing easy to use API for using OBEX"
HOMEPAGE="http://tadas.dailyda.com/blog/category/obex-data-server/"
SRC_URI="http://tadas.dailyda.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"

IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/dbus-glib-0.7
	>=net-wireless/bluez-libs-3.13
	>=dev-libs/openobex-1.3"
DEPEND="
	dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
