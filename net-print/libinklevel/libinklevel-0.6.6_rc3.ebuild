# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libinklevel/libinklevel-0.6.6_rc3.ebuild,v 1.1 2006/09/16 14:51:23 genstef Exp $

DESCRIPTION="A library to get the ink level of your printer"
HOMEPAGE="http://libinklevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/libinklevel/${P/_}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE=""

DEPEND="sys-libs/libieee1284"

S=${WORKDIR}/${PN}

src_install () {
	emake DESTDIR=${D}/usr install || die "emake install failed"
	dodoc README
}

