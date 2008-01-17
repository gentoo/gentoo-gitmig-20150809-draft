# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.03.ebuild,v 1.5 2008/01/17 04:27:46 jer Exp $

inherit flag-o-matic eutils

DESCRIPTION="UCL: The UCL Compression Library"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_compile() {
	epunt_cxx #76771
	econf --enable-shared || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README THANKS TODO
}
