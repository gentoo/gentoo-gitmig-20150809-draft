# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmicrohttpd/libmicrohttpd-0.9.0.ebuild,v 1.2 2010/09/18 22:13:05 chithanh Exp $

EAPI=2

MY_P=${P/_/}

DESCRIPTION="A small C library that makes it easy to run an HTTP server as part of another application."
HOMEPAGE="http://gnunet.org/libmicrohttpd/"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz"

IUSE="messages ssl"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="ssl? (
		>=dev-libs/libgcrypt-1.2.2
		net-libs/gnutls
	)
	>=net-misc/curl-7.16.4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--enable-curl \
		$(use_enable messages) \
		$(use_enable ssl https) \
		$(use_with ssl gnutls)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS NEWS README ChangeLog || die
}
