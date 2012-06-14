# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libproplist/libproplist-0.10.1-r4.ebuild,v 1.1 2012/06/14 15:43:21 ssuominen Exp $

EAPI=4

MY_P=libPropList-${PV}

inherit autotools eutils

DESCRIPTION="libPropList"
HOMEPAGE="http://www.windowmaker.org/"
SRC_URI="ftp://ftp.windowmaker.org/pub/libs/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="static-libs"

DOCS=( AUTHORS ChangeLog README TODO )

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-include.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"/usr/lib*/libPropList.la
}
