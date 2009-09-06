# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtranslate/libtranslate-0.99.ebuild,v 1.5 2009/09/06 21:54:44 vostorga Exp $

EAPI=1

inherit eutils autotools

DESCRIPTION="Library for translating text and web pages between natural languages."
HOMEPAGE="http://www.nongnu.org/libtranslate"
SRC_URI="http://savannah.nongnu.org/download/libtranslate/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# The tests require the package to be installed already.
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.4
	net-libs/libsoup:2.4
	>=dev-libs/libxml2-2
	>=app-text/talkfilters-2.3.4-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Upstream patches for several minor issues.
	epatch "${FILESDIR}"/${P}-charsetparse.diff \
		"${FILESDIR}"/${P}-condfix.diff \
		"${FILESDIR}"/${P}-int64.diff \
		"${FILESDIR}"/${P}-man-page.diff \
		"${FILESDIR}"/${P}-libsoup24.diff

	einfo "Running intltoolize --force --copy --automake"
	intltoolize --force --copy --automake || die "intltoolize failed"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
}
