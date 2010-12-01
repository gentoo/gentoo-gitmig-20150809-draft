# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmicrohttpd/libmicrohttpd-0.9.3.ebuild,v 1.1 2010/12/01 15:49:25 chithanh Exp $

EAPI=2

MY_P=${P/_/}

DESCRIPTION="A small C library that makes it easy to run an HTTP server as part of another application."
HOMEPAGE="http://gnunet.org/libmicrohttpd/"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz"

IUSE="messages ssl test"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="ssl? (
		dev-libs/libgcrypt
		net-libs/gnutls
	)
	net-misc/curl"
# Some tests fail if curl is built against nss, bug #334067
DEPEND="${RDEPEND}
	test?	(
		ssl? ( || (
			>=net-misc/curl-7.21[ssl,-nss]
			>=net-misc/curl-7.21[ssl,gnutls]
		) )
	)"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--enable-curl \
		$(use messages || use_enable messages) \
		$(use ssl || use_enable ssl https) \
		$(use_with ssl gnutls)
}
# SSL is disabled when --enable-https is passed
# messages are disabled when --enable-messages is passed

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS NEWS README ChangeLog || die
}
