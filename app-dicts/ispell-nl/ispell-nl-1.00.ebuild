# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-nl/ispell-nl-1.00.ebuild,v 1.7 2009/02/25 13:04:00 josejx Exp $

inherit multilib

DESCRIPTION="A dutch (spelling 2005) dictionary for ispell"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://opentaal.nl"

SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""
KEYWORDS="~alpha amd64 ~hppa ~mips ~ppc ~sparc x86"

DEPEND="app-text/ispell"

src_compile() {
	/usr/bin/buildhash -s "${S}/words-nl.ispell" "${S}/dutch.aff" \
				"${S}/dutch.hash" || die "buildhash failed"
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins dutch.aff dutch.hash || die
}
