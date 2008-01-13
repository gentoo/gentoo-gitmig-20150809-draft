# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-1.06.09.ebuild,v 1.9 2008/01/13 14:19:35 philantrop Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="curl libwww threads"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/libxml2
	libwww? ( net-libs/libwww
			>=dev-libs/openssl-0.9.8g )
	curl? ( net-misc/curl )"

pkg_setup() {
	# parallel make doesn't work
	MAKEOPTS="-j1"

	if ! use curl && ! use libwww; then
		ewarn "Neither CURL nor libwww support was selected"
		ewarn "No client library will be be built"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.05-pic.patch
	epatch "${FILESDIR}"/${PN}-1.06.02-threadupdatestatus.patch
	epatch "${FILESDIR}"/${PN}-1.06.02-strsol.patch

	# Respect the user's CFLAGS/CXXFLAGS.
	sed -i -e "/CFLAGS_COMMON/s:-g -O3$:${CFLAGS}:" Makefile.common
	sed -i -e "/CXXFLAGS_COMMON/s:-g$:${CXXFLAGS}:" Makefile.common
}

src_compile() {
	econf --disable-wininet-client --enable-libxml2-backend \
		$(use_enable threads abyss-threads) \
		$(use_enable curl curl-client) \
		$(use_enable libwww libwww-client) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	dodoc README doc/CREDITS doc/DEVELOPING doc/HISTORY doc/SECURITY doc/TESTING \
		doc/TODO || die "installing docs failed"
}
