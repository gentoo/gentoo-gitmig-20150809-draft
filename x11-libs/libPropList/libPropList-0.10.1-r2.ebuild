# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r2.ebuild,v 1.15 2009/05/05 08:02:11 ssuominen Exp $

DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/${P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "
IUSE=""

RDEPEND=""
DEPEND=""

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	make || die
}

src_install() {
	make prefix="${D}/usr" install || die
	dodoc AUTHORS ChangeLog README TODO
}
