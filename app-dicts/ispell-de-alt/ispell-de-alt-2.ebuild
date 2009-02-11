# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-de-alt/ispell-de-alt-2.ebuild,v 1.1 2009/02/11 14:50:45 ulm Exp $

inherit multilib

MY_P="hk${PV}-deutsch"
DESCRIPTION="German dictionary (classic orthography) for ispell"
HOMEPAGE="http://www.lasr.cs.ucla.edu/geoff/ispell-dictionaries.html"
SRC_URI="ftp://ftp.informatik.uni-kiel.de/pub/kiel/dicts/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/ispell"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins deutsch.aff deutsch.hash || die "doins failed"
	dodoc ANNOUNCE Changes Contributors README
}
