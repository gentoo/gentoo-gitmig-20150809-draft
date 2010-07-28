# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quvi/quvi-0.2.1.ebuild,v 1.1 2010/07/28 20:25:54 hanno Exp $

EAPI=2

DESCRIPTION="library for parsing video download links"
HOMEPAGE="http://code.google.com/p/quvi/"
SRC_URI="http://quvi.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples test offensive"

RDEPEND=">=net-misc/curl-7.18.0
	>=dev-libs/libpcre-7.9[cxx]
	dev-lang/lua[deprecated]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# tests fetch data from live websites, so it's rather normal that they
# will fail
RESTRICT="test"

src_configure() {
	econf \
		--without-doc \
		$(use_enable examples) \
		$(use_enable offensive smut) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO || die "dodoc failed"
	use doc && dodoc doc/How*
}
