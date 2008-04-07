# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librelp/librelp-0.1.0.ebuild,v 1.1 2008/04/07 21:14:10 dev-zero Exp $

DESCRIPTION="An easy to use library for the RELP protocol."
HOMEPAGE="http://www.librelp.com/"
SRC_URI="http://download.rsyslog.com/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND=""
RDEPEND=""

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
	dohtml doc/relp.html
}
