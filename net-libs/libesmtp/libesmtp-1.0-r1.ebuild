# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libesmtp/libesmtp-1.0-r1.ebuild,v 1.8 2004/02/07 00:26:50 agriffis Exp $

inherit gcc eutils gnuconfig libtool

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="libESMTP is a library that implements the client side of the SMTP protocol"
SRC_URI="http://www.stafford.uklinux.net/libesmtp/${P}.tar.bz2"
HOMEPAGE="http://www.stafford.uklinux.net/libesmtp/"

DEPEND=">=sys-devel/libtool-1.4.1
	ssl? ( >=dev-libs/openssl-0.9.6b )
	>=sys-apps/sed-4"

RDEPEND=""

SLOT="0"
LICENSE="LGPL-2.1 GPL-2"
KEYWORDS="x86 sparc ~ppc alpha"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-openssl.patch
}

src_compile() {
	gnuconfig_update

	elibtoolize

	local myconf

	use ssl || myconf="${myconf} --without-openssl"

	if [ "`gcc-major-version`" -eq "2"  ]; then
		myconf="${myconf} --disable-isoc"
	fi

	./configure --prefix=/usr \
		--enable-all \
		--enable-threads \
		${myconf} || die "configure failed"

	if [ "`gcc-major-version`" -eq "3" ] && [ "`gcc-minor-version`" -ge "3" ]; then
		sed -i "s:-Wsign-promo::g" Makefile
	fi

	emake || die "emake failed"
}

src_install () {
	make prefix=${D}/usr install || die "make install failed"
	dodoc AUTHORS COPYING COPYING.GPL INSTALL ChangeLog NEWS Notes README TODO
	dohtml doc/api.xml
}

