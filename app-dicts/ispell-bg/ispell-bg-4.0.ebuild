# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-bg/ispell-bg-4.0.ebuild,v 1.3 2005/07/08 13:32:40 dholm Exp $

DESCRIPTION="Bulgarian dictionary for ispell"
SRC_URI="mirror://sourceforge/bgoffice/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/bgoffice"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="app-text/ispell"

src_install () {
	insinto /usr/lib/ispell
	doins ${S}/data/bulgarian.aff ${S}/data/bulgarian.hash
}
