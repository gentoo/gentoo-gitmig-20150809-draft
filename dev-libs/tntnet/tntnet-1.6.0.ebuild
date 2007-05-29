# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tntnet/tntnet-1.6.0.ebuild,v 1.1 2007/05/29 13:57:40 zzam Exp $

DESCRIPTION="A modular, multithreaded webapplicationserver written from scratch for C++."
HOMEPAGE="http://www.tntnet.org/index.hms"
SRC_URI="http://www.tntnet.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/cxxtools
	>=net-libs/gnutls-1.2.0"

src_compile() {
	econf --with-ssl=gnutls \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO
}

