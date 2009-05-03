# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/iksemel/iksemel-1.3.ebuild,v 1.6 2009/05/03 16:47:36 arfrever Exp $

DESCRIPTION="eXtensible Markup Language parser library designed for Jabber applications"
HOMEPAGE="http://code.google.com/p/iksemel"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnutls"

RDEPEND="gnutls? ( net-libs/gnutls )"
DEPEND="${RDEPEND}"

# http://code.google.com/p/iksemel/issues/detail?id=4
RESTRICT="test"

src_compile() {
	econf $(use_with gnutls libgnutls-prefix /usr)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
