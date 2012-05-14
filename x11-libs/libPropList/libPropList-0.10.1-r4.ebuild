# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r4.ebuild,v 1.2 2012/05/14 16:52:25 kensington Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="libPropList"
HOMEPAGE="http://www.windowmaker.org/"
SRC_URI="ftp://ftp.windowmaker.org/pub/libs/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="static-libs"

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${P}-include.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
