# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtranslate/libtranslate-0.99-r1.ebuild,v 1.1 2010/10/07 15:41:52 jer Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Library for translating text and web pages between natural languages."
HOMEPAGE="http://www.nongnu.org/libtranslate"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4
	net-libs/libsoup:2.4
	>=dev-libs/libxml2-2
	>=app-text/talkfilters-2.3.4-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

src_prepare() {
	# Upstream patches for several minor issues.
	epatch "${FILESDIR}"/${P}-charsetparse.diff \
		"${FILESDIR}"/${P}-condfix.diff \
		"${FILESDIR}"/${P}-int64.diff \
		"${FILESDIR}"/${P}-man-page.diff \
		"${FILESDIR}"/${P}-libsoup24.diff \
		"${FILESDIR}"/${P}-services.diff \
		"${FILESDIR}"/${P}-services2.diff

	einfo "Running intltoolize --force --copy --automake"
	intltoolize --force --copy --automake || die "intltoolize failed"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_test() {
	if has_version ${CATEGORY}/${PN}; then
		emake check || die
	else
		einfo "The test suite can only run after installation"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
}

pkg_setup() {
	elog "It is probably a good idea to maintain and update your own"
	elog "~/.libtranslate/services.xml. See services.xml(5) for details."
}
