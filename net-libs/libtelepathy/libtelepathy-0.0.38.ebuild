# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtelepathy/libtelepathy-0.0.38.ebuild,v 1.1 2006/10/22 16:56:25 peper Exp $

DESCRIPTION="A glib based library for Telepathy client development"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/glib-2.4
	>=sys-apps/dbus-0.61"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
