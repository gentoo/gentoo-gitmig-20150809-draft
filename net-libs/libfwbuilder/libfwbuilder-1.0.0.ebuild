# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-0.10.8.ebuild,v 1.0

IUSE="ssl static"

DESCRIPTION="A firewall GUI (library functions)"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://www.fwbuilder.org/"
S=${WORKDIR}/${P}

KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-devel/autoconf
	=dev-libs/glib-1.2*
        >=dev-libs/libxml2-2.4.19
        !=dev-libs/libxml2-2.4.25
        >=dev-libs/libxslt-1.0.15
	snmp? ( virtual/snmp )
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf
	
	use static && myconf="${myconf} --disable-shared --enable-static=yes"
	use ssl || myconf="${myconf} --without-openssl"

	./autogen.sh \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} || die "./configure failed"

	if [ "`use static`" ] ; then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	prepalldocs
}
