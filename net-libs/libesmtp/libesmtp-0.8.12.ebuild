# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libesmtp/libesmtp-0.8.12.ebuild,v 1.5 2002/08/01 11:59:03 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libESMTP is a library that implements the client side of the SMTP protocol"
SRC_URI="http://www.stafford.uklinux.net/libesmtp/${P}.tar.bz2"
HOMEPAGE="http://www.stafford.uklinux.net/libesmtp/index.html"

DEPEND=">=sys-devel/libtool-1.3.5-r2
	ssl? ( >=dev-libs/openssl-0.9.6b )"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {
	local myconf
	use ssl || myconf="${myconf} --without-openssl"

	./configure --prefix=/usr ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	make prefix=${D}/usr install || die "make install failed"
	dodoc AUTHORS COPYING COPYING.GPL INSTALL ChangeLog NEWS Notes README TODO 
	dohtml doc/api.xml
}

