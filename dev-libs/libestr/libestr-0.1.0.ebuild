# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libestr/libestr-0.1.0.ebuild,v 1.1 2011/02/22 16:42:53 hwoarang Exp $

EAPI=3

DESCRIPTION="Library for some string essentials"
HOMEPAGE="http://libestr.adiscon.com/"
SRC_URI="http://libestr.adiscon.com/files/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure()	{
	econf $(use_enable debug)
}

src_install()	{
	emake install DESTDIR="${D}" || die "make install failed"
	find "${D}" -name "*.la" -delete || die "remove of la files failed"
}