# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libesmtp/libesmtp-1.0.3.ebuild,v 1.7 2005/04/08 18:03:37 hansmi Exp $

inherit gcc eutils gnuconfig libtool

MY_P="${P}r1"
DESCRIPTION="libESMTP is a library that implements the client side of the SMTP protocol"
SRC_URI="http://www.stafford.uklinux.net/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://www.stafford.uklinux.net/${PN}/"
LICENSE="LGPL-2.1 GPL-2"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.4.1
	>=sys-apps/sed-4"

IUSE="ssl"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"

S="${WORKDIR}/${MY_P}"

src_compile() {
	gnuconfig_update

	elibtoolize

	local myconf

	use ssl || myconf="${myconf} --without-openssl"

	if [ "`gcc-major-version`" -eq "2"  ]; then
		myconf="${myconf} --disable-isoc"
	fi

	./configure \
		--prefix=/usr \
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
