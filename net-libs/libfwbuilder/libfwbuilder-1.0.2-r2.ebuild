# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-1.0.2-r2.ebuild,v 1.6 2005/02/07 17:21:32 carlo Exp $

inherit eutils

IUSE="ssl snmp"

DESCRIPTION="A firewall GUI (library functions)"
SRC_URI="mirror://gentoo/${P}-2.tar.gz
	gentoo.tamperd.net/distfiles/${P}-2.tar.gz"
HOMEPAGE="http://www.fwbuilder.org/"

KEYWORDS="x86 sparc amd64 ppc"
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
	./autogen.sh \
		--prefix=/usr \
		--host=${CHOST} \
		`use_with ssl openssl` || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	prepalldocs
}
