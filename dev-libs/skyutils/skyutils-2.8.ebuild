# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skyutils/skyutils-2.8.ebuild,v 1.6 2007/05/23 09:33:52 mrness Exp $

DESCRIPTION="Library of assorted C utility functions."
HOMEPAGE="None available" # was "http://zekiller.skytech.org/coders_en.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_compile() {
	econf `use_enable ssl` || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog
}
