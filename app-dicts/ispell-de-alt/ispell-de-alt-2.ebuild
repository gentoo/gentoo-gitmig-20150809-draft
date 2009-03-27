# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-de-alt/ispell-de-alt-2.ebuild,v 1.13 2009/03/27 23:09:10 jer Exp $

inherit eutils multilib

DESCRIPTION="German dictionary (traditional orthography) for ispell"
HOMEPAGE="http://www.lasr.cs.ucla.edu/geoff/ispell-dictionaries.html"
SRC_URI="ftp://ftp.informatik.uni-kiel.de/pub/kiel/dicts/hk${PV}-deutsch.tar.gz
	http://www.j3e.de/ispell/hk2/hkgerman_2-patch-bj1.diff.gz"

# GPL according to <http://bugs.debian.org/131124#25>
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"
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
	dosym deutsch.aff /usr/$(get_libdir)/ispell/de_DE_1901.aff || die
	dosym deutsch.hash /usr/$(get_libdir)/ispell/de_DE_1901.hash || die
	dodoc ANNOUNCE Changes Contributors README*
}
