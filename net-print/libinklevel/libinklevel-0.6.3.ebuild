# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libinklevel/libinklevel-0.6.3.ebuild,v 1.2 2004/08/24 11:11:03 lanius Exp $

DESCRIPTION="A library to get the ink level of your printer"
HOMEPAGE="http://libinklevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/libinklevel/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE=""

DEPEND="sys-libs/libieee1284"

S=${WORKDIR}/${PN}

src_install () {
	make DESTDIR=${D}/usr install || die
	dodoc COPYING README
}

