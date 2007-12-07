# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtelepathy/libtelepathy-0.3.1.ebuild,v 1.2 2007/12/07 15:45:07 peper Exp $

inherit flag-o-matic

DESCRIPTION="A glib based library for Telepathy client development"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.10
	>=dev-libs/dbus-glib-0.73
	>=net-libs/telepathy-glib-0.7.0"

DEPEND="${RDEPEND}
	dev-libs/libxslt"

src_compile() {
	# Force at least -O1
	# https://bugs.freedesktop.org/show_bug.cgi?id=13560
	export CFLAGS="-O1 ${CFLAGS}"
	replace-flags -O0 -O1

	econf
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
