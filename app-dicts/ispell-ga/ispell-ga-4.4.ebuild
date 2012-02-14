# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ga/ispell-ga-4.4.ebuild,v 1.5 2012/02/14 22:53:43 ranger Exp $

inherit multilib

MY_P=ispell-gaeilge-${PV}
DESCRIPTION="Irish dictionary for ispell"
HOMEPAGE="http://borel.slu.edu/ispell/"
SRC_URI="http://borel.slu.edu/ispell/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~mips ppc ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins gaeilge.hash gaeilge.aff || die
	dodoc README
}
