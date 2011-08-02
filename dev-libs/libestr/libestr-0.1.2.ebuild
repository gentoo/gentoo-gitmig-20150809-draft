# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libestr/libestr-0.1.2.ebuild,v 1.1 2011/08/02 14:21:11 hwoarang Exp $

EAPI=4

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
	emake install DESTDIR="${D}"
	find "${D}" -name "*.la" -delete || die
}
