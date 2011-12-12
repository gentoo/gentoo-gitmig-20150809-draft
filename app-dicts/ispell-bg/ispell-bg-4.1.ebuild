# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-bg/ispell-bg-4.1.ebuild,v 1.6 2011/12/12 13:00:07 jer Exp $

inherit multilib

DESCRIPTION="Bulgarian dictionary for ispell"
HOMEPAGE="http://sourceforge.net/projects/bgoffice"
SRC_URI="mirror://sourceforge/bgoffice/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 hppa ~mips ~ppc ~sparc ~x86"

DEPEND="app-text/ispell"

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins "${S}/data/bulgarian.aff" "${S}/data/bulgarian.hash" || die
}
