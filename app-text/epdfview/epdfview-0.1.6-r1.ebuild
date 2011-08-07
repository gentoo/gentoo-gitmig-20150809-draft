# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/epdfview/epdfview-0.1.6-r1.ebuild,v 1.15 2011/08/07 12:54:30 billie Exp $

EAPI="2"
inherit eutils

DESCRIPTION="Lightweight PDF viewer using Poppler and GTK+ libraries."
HOMEPAGE="http://trac.emma-soft.com/epdfview/"
SRC_URI="http://trac.emma-soft.com/epdfview/chrome/site/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="cups nls test"

COMMON_DEPEND=">=app-text/poppler-0.12.3-r3[cairo]
	>=x11-libs/gtk+-2.6:2
	cups? ( >=net-print/cups-1.1 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.9
	nls? ( sys-devel/gettext )
	test? ( dev-util/cppunit )"
RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
	epatch "${FILESDIR}/${P}-print-segfault.patch"
}

src_configure() {
	econf \
		$(use_enable cups) \
		$(use_with nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS
}
