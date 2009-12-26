# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/iksemel/iksemel-1.4.ebuild,v 1.1 2009/12/26 12:58:36 pva Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="eXtensible Markup Language parser library designed for Jabber applications"
HOMEPAGE="http://code.google.com/p/iksemel"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

RDEPEND="ssl? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
		ssl? ( dev-util/pkgconfig )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.3-gnutls-2.8.patch"
	eautoreconf
}

src_configure() {
	econf $(use_with ssl gnutls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
