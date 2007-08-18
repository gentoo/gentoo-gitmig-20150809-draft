# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt/ispell-pt-20070709.ebuild,v 1.1 2007/08/18 17:12:34 philantrop Exp $

DESCRIPTION="A Portuguese dictionary for ispell"
SRC_URI="http://natura.di.uminho.pt/download/sources/Dictionaries/ispell/ispell.pt-${PV}.tar.gz"
HOMEPAGE="http://natura.di.uminho.pt"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND="app-text/ispell"

S="${WORKDIR}/${P/-/.}"

src_install () {
	insinto /usr/lib/ispell
	doins portugues.aff portugues.hash

	dodoc README || die "installing docs failed"
}
