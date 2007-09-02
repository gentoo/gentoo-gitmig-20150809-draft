# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtranslate/libtranslate-0.99.ebuild,v 1.1 2007/09/02 18:47:02 philantrop Exp $

inherit eutils

DESCRIPTION="Library for translating text and web pages between natural languages."
HOMEPAGE="http://www.nongnu.org/libtranslate"
SRC_URI="http://savannah.nongnu.org/download/libtranslate/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
IUSE=""

# The tests require the package to be installed already.
RESTRICT="test"

DEPEND=">=dev-libs/glib-2.4.0
		>=net-libs/libsoup-2.2.0
		>=dev-libs/libxml2-2.0
		>=app-text/talkfilters-2.3.4-r1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	# Upstream patches for several minor issues.
	epatch "${FILESDIR}/${P}-charsetparse.diff"
	epatch "${FILESDIR}/${P}-condfix.diff"
	epatch "${FILESDIR}/${P}-int64.diff"
	epatch "${FILESDIR}/${P}-man-page.diff"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	dodoc AUTHORS NEWS README TODO || die "installing docs failed"
}
