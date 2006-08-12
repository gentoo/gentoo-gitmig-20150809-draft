# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-1.06.03.ebuild,v 1.2 2006/08/12 09:50:36 hollow Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tgz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="curl libwww threads"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	dev-libs/libxml2
	libwww? ( net-libs/libwww )
	curl? ( net-misc/curl )"

pkg_setup() {
	# paralell make doesn't work
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
	epatch "${FILESDIR}"/${PN}-1.06.03-mustbuildclient.patch
}

src_compile() {
	econf --disable-wininet-client --enable-libxml2-backend \
		$(use_enable threads abyss-threads) \
		$(use_enable curl curl-client) \
		$(use_enable libwww libwww-client) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
