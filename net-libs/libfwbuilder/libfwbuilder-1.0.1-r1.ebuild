# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-1.0.1-r1.ebuild,v 1.7 2004/07/15 00:51:08 agriffis Exp $

inherit eutils

IUSE="snmp ssl static"

DESCRIPTION="A firewall GUI (library functions)"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://www.fwbuilder.org/"

KEYWORDS="x86 sparc ~amd64"
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

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-libxml2.patch
}

src_compile() {
	local myconf

	use static && myconf="${myconf} --disable-shared --enable-static=yes"

	./autogen.sh \
		--prefix=/usr \
		--host=${CHOST} \
		`use_with ssl openssl`
		${myconf} || die "./configure failed"

	if use static ; then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	prepalldocs
}
