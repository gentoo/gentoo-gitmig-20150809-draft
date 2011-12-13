# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libkpass/libkpass-3.ebuild,v 1.1 2011/12/13 17:31:34 joker Exp $

EAPI=4

DESCRIPTION="Libkpass is a from-scratch C implementation of accessing KeePass 1.x format password databases"
HOMEPAGE="http://libkpass.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO README AUTHORS ChangeLog
}
