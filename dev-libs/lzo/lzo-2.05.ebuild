# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/lzo/lzo-2.05.ebuild,v 1.1 2011/08/03 18:02:56 sping Exp $

EAPI=2

DESCRIPTION="An extremely fast compression and decompression library"
HOMEPAGE="http://www.oberhumer.com/opensource/lzo/"
SRC_URI="http://www.oberhumer.com/opensource/lzo/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="examples static-libs"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS doc/* || die

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h} || die
	fi

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
