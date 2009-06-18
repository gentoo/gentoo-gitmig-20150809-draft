# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtelepathy/libtelepathy-0.3.3.ebuild,v 1.7 2009/06/18 13:03:46 aballier Exp $

inherit flag-o-matic libtool

DESCRIPTION="A glib based library for Telepathy client development"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.10
	>=dev-libs/dbus-glib-0.73
	>=net-libs/telepathy-glib-0.7.1"


src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize # for a sane .so versionning on BSD
}

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
