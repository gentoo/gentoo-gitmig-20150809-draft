# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hyphen/hyphen-2.4.ebuild,v 1.1 2010/01/05 20:41:55 ssuominen Exp $

EAPI=2

DESCRIPTION="hyphenation library to use converted TeX hyphenation patterns"
HOMEPAGE="http://sourceforge.net/projects/hunspell/"
SRC_URI="mirror://sourceforge/hunspell/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
	insinto /usr/share/doc/${PF}/pdf
	doins doc/*.pdf
	find "${D}"/usr -name '*.la' -delete
}
