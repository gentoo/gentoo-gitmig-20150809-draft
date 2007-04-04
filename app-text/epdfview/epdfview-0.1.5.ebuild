# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/epdfview/epdfview-0.1.5.ebuild,v 1.12 2007/04/04 20:45:27 gustavoz Exp $

inherit eutils

DESCRIPTION="Lightweight PDF viewer using Poppler and GTK+ libraries."
HOMEPAGE="http://trac.emma-soft.com/epdfview/"
SRC_URI="http://trac.emma-soft.com/epdfview/chrome/site/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="cups nls test"

COMMON_DEPEND=">=app-text/poppler-bindings-0.5.0
	>=x11-libs/gtk+-2.6
	cups? ( >=net-print/cups-1.1 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.9
	nls? ( sys-devel/gettext )
	test? ( dev-util/cppunit )"
RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )"

pkg_setup() {
	if ! built_with_use app-text/poppler-bindings gtk; then
		eerror "Please re-emerge app-text/poppler-bindings with the gtk USE flag set."
		die "poppler-bindings needs gtk flag set."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/search_fix.patch
}

src_compile() {
	econf \
		$(use_enable cups) \
		$(use_with nls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS
}
