# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-1.0.2.ebuild,v 1.2 2003/12/12 22:05:36 aliz Exp $

IUSE="ssl static"

DESCRIPTION="A firewall GUI (library functions)"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://www.fwbuilder.org/"
S=${WORKDIR}/${P}

KEYWORDS="~x86 ~sparc ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-devel/libtool
	sys-devel/autoconf
	=dev-libs/glib-1.2*
	>=dev-libs/libxml2-2.4.19
	!=dev-libs/libxml2-2.4.25
	>=dev-libs/libxslt-1.0.15
	snmp? ( virtual/snmp )
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf

	use static && myconf="${myconf} --disable-shared --enable-static=yes"

	./autogen.sh \
		--prefix=/usr \
		--host=${CHOST} \
		`use_with ssl openssl`
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
