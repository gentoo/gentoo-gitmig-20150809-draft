# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eggdbus/eggdbus-0.6.ebuild,v 1.16 2010/08/09 02:05:28 josejx Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="D-Bus bindings for GObject"
HOMEPAGE="http://cgit.freedesktop.org/~david/eggdbus"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="debug doc +largefile test"

RDEPEND=">=dev-libs/dbus-glib-0.73
	>=dev-libs/glib-2.19:2
	>=sys-apps/dbus-1.0"
DEPEND="${DEPEND}
	doc? ( dev-libs/libxslt
		>=dev-util/gtk-doc-1.3 )
	dev-util/pkgconfig
	dev-util/gtk-doc-am"

# NOTES:
# man pages are built (and installed) when doc is enabled

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4-ldflags.patch \
		"${FILESDIR}"/${PN}-0.4-tests.patch \
		"${FILESDIR}"/${P}-include-types.h.patch

	eautoreconf
}

src_configure() {
	# ansi: build fails with
	# verbose-mode: looks useless
	# largefile: not sure usefull
	econf \
		--disable-maintainer-mode \
		--disable-dependency-tracking \
		--disable-ansi \
		$(use_enable debug verbose-mode) \
		$(use_enable doc gtk-doc) \
		$(use_enable doc man-pages) \
		$(use_enable largefile) \
		$(use_enable test tests)
}

src_compile() {
	emake -C src/eggdbus eggdbusenumtypes.h || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog HACKING NEWS README || die
}
