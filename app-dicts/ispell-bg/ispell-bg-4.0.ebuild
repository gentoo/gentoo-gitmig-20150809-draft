# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-bg/ispell-bg-4.0.ebuild,v 1.2 2005/07/05 00:57:57 arj Exp $

DESCRIPTION="Bulgarian dictionary for ispell"
SRC_URI="mirror://sourceforge/bgoffice/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/bgoffice"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="app-text/ispell"

src_install () {
	insinto /usr/lib/ispell
	doins ${S}/data/bulgarian.aff ${S}/data/bulgarian.hash
}
