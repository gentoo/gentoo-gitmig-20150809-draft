# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pius/pius-2.0.8.ebuild,v 1.1 2011/02/14 12:59:44 tomk Exp $

DESCRIPTION="A tool for signing and email all UIDs on a set of PGP keys."
HOMEPAGE="http://www.phildev.net/pius/"
SRC_URI="mirror://sourceforge/pgpius/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="=dev-lang/python-2*
		app-crypt/gnupg"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN}
	dodoc Changelog README
}
