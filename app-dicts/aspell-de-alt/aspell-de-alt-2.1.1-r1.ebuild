# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-de-alt/aspell-de-alt-2.1.1-r1.ebuild,v 1.4 2009/12/14 17:38:07 jer Exp $

ASPELL_LANG="German (traditional orthography)"
ASPOSTFIX="6"

inherit eutils aspell-dict

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-dict-name.patch"
}

src_install() {
	aspell-dict_src_install
	newdoc doc/README README.hk || die
	dodoc doc/README.bj || die
}
