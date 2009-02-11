# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-de-alt/ispell-de-alt-2.ebuild,v 1.3 2009/02/11 23:01:53 klausman Exp $

inherit eutils multilib

DESCRIPTION="German dictionary (classic orthography) for ispell"
HOMEPAGE="http://www.lasr.cs.ucla.edu/geoff/ispell-dictionaries.html"
SRC_URI="ftp://ftp.informatik.uni-kiel.de/pub/kiel/dicts/hk${PV}-deutsch.tar.gz
	http://www.j3e.de/ispell/hk2/hkgerman_2-patch-bj1.diff.gz"

# GPL according to <http://bugs.debian.org/131124#25>
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND="app-text/ispell"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch hkgerman_2-patch-bj1.diff
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins deutsch.aff deutsch.hash || die "doins failed"
	dodoc ANNOUNCE Changes Contributors README*
}
