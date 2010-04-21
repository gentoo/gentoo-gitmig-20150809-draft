# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/orc/orc-0.4.4.ebuild,v 1.2 2010/04/21 16:12:24 ssuominen Exp $

EAPI=2

DESCRIPTION="The Oil Runtime Compiler"
HOMEPAGE="http://code.entropywave.com/projects/orc/"
SRC_URI="http://code.entropywave.com/download/orc/${P}.tar.gz"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	econf \
		--disable-static \
		--disable-dependency-tracking \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TODO
	
	find "${D}" -name '*.la' -delete
}
