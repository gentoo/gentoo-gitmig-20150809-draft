# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-0.10.7.ebuild,v 1.4 2002/08/16 02:57:06 murphy Exp $

MY_PN=${PN/lib/}
DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/${MY_PN}/${P}.tar.gz"
HOMEPAGE="http://fwbuilder.sourceforge.net"

KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="( >=dev-libs/libsigc++-1.0.4-r1
	<dev-libs/libsigc++-1.1.0 )
	>=dev-libs/libxslt-1.0.7-r1
	>=net-analyzer/ucd-snmp-4.2.3
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf
	
	use static && myconf="${myconf} --disable-shared --enable-static=yes"
	use ssl || myconf="${myconf} --without-openssl"

	./configure \
		--prefix=/usr \
		--host=${CHOST}	\
		${myconf} || die "./configure failed"

	if [ "`use static`" ] ; then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install () {
	emake DESTDIR=${D} install || die "emake install failed"
	prepalldocs
}

