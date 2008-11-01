# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ga/ispell-ga-4.4.ebuild,v 1.1 2008/11/01 09:28:28 pva Exp $

MY_P=ispell-gaeilge-${PV}

DESCRIPTION="Irish dictionary for ispell"
HOMEPAGE="http://borel.slu.edu/ispell/"
SRC_URI="http://borel.slu.edu/ispell/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/ispell
	doins gaeilge.hash gaeilge.aff || die
	dodoc README
}
