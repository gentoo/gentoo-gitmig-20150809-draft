# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cclive/cclive-0.5.6.ebuild,v 1.1 2009/12/16 14:01:20 aballier Exp $

EAPI=2

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://code.google.com/p/cclive/"
SRC_URI="http://cclive.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND=">=net-misc/curl-7.18.0
	>=dev-libs/libpcre-7.9[cxx]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--with-man \
		$(use_enable test tests)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}

src_test() {
	einfo "Tests require internet connection in order to work."
	ADULT_OK="true" emake check || die "emake test failed"
}
