# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libesmtp/libesmtp-0.8.12.ebuild,v 1.16 2004/07/15 00:50:36 agriffis Exp $

IUSE="ssl"

DESCRIPTION="libESMTP is a library that implements the client side of the SMTP protocol"
SRC_URI="http://www.stafford.uklinux.net/libesmtp/${P}.tar.bz2"
HOMEPAGE="http://www.stafford.uklinux.net/libesmtp/"

DEPEND=">=sys-devel/libtool-1.3.5-r2
	ssl? ( >=dev-libs/openssl-0.9.6b )"

SLOT="0"
LICENSE="LGPL-2.1 GPL-2"
KEYWORDS="x86 sparc ppc"

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
