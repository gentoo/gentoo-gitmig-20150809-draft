# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/iksemel/iksemel-1.3.ebuild,v 1.1 2007/11/11 18:16:28 drac Exp $

DESCRIPTION="eXtensible Markup Language parser library designed for Jabber applications"
HOMEPAGE="http://code.google.com/p/iksemel"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnutls"

RDEPEND="gnutls? ( net-libs/gnutls )"
DEPEND="${RDEPEND}"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
