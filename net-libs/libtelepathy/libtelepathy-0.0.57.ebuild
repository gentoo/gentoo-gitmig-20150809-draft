# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtelepathy/libtelepathy-0.0.57.ebuild,v 1.1 2007/09/07 22:50:46 peper Exp $

DESCRIPTION="A glib based library for Telepathy client development"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4
	>=dev-libs/dbus-glib-0.71"

DEPEND="${RDEPEND}
	dev-libs/libxslt"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
