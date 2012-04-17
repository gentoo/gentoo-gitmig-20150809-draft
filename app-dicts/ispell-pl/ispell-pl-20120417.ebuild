# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pl/ispell-pl-20120417.ebuild,v 1.1 2012/04/17 15:00:19 scarabeus Exp $

EAPI=4

MY_P="sjp-${P}"

inherit multilib

DESCRIPTION="Polish dictionary for ispell"
HOMEPAGE="http://www.sjp.pl/slownik/en/"
SRC_URI="http://sjp.pl/slownik/ort/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell"

S="${WORKDIR}/${MY_P}"

src_compile() {
	iconv -f iso8859-2 -t utf-8 polish.all -o polish.all.utf
	./build polish.all.utf || die
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins polish.aff polish.hash
	dodoc README
}
