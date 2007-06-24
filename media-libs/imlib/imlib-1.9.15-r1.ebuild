# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.15-r1.ebuild,v 1.17 2007/06/24 22:07:17 kumba Exp $

inherit autotools eutils gnome.org

DESCRIPTION="Image loading and rendering library"
HOMEPAGE="http://www.enlightenment.org/Libraries/Imlib.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=media-libs/tiff-3.5.5
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix aclocal underquoted definition warnings.
	# Conditionalize gdk functions for bug 40453.
	# Fix imlib-config for bug 3425.
	epatch "${FILESDIR}"/${P}.patch

	# Fix security bug 72681.
	epatch "${FILESDIR}"/${PN}-security.patch

	eautoconf
	_elibtoolize
}

src_compile() {
	econf --sysconfdir=/etc/imlib \
		$(use_enable gtk gdk) \
		$(use_enable gtk gtktest)

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodoc AUTHORS ChangeLog README
	use doc && dohtml doc/*

	# Hack to avoid installing pkgconfig file.
	use gtk || rm "${D}"/usr/lib*/pkgconfig/imlibgdk.pc
}
