# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/epdfview/epdfview-0.1.7-r2.ebuild,v 1.1 2009/04/26 13:22:25 loki_val Exp $

EAPI="2"

inherit gnome2 flag-o-matic eutils

DESCRIPTION="Lightweight PDF viewer using Poppler and GTK+ libraries."
HOMEPAGE="http://trac.emma-soft.com/epdfview/"
SRC_URI="http://trac.emma-soft.com/epdfview/chrome/site/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="cups nls test"

RDEPEND=">=virtual/poppler-glib-0.5.0[cairo]
	>=x11-libs/gtk+-2.6
	cups? ( >=net-print/cups-1.1 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	nls? ( sys-devel/gettext )
	test? ( dev-util/cppunit )
	userland_GNU? ( >=sys-apps/findutils-4.4.0 )"

pkg_setup() {
	G2CONF=$(use_with cups)
	DOCS="AUTHORS NEWS README THANKS"
}

src_prepare() {
	gnome2_src_prepare
	sed -i -e 's:Icon=icon_epdfview-48:Icon=epdfview:' data/epdfview.desktop || die "desktop sed failed"
	epatch "${FILESDIR}"/${PN}-0.1.7-mouse-scrolling.patch
}

src_install() {
	gnome2_src_install
	for size in 24 32 48
	do
		icnsdir="/usr/share/icons/hicolor/${size}x${size}/apps/"
		insinto "${icnsdir}" || die "insinto failed"
		newins data/icon_epdfview-${size}.png epdfview.png || die "newins failed"
	done
}
