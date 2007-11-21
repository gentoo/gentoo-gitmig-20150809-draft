# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-nl/ispell-nl-1.00.ebuild,v 1.1 2007/11/21 11:15:43 philantrop Exp $

inherit multilib

DESCRIPTION="A dutch (spelling 2005) dictionary for ispell"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://opentaal.nl"

SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-text/ispell"

src_compile() {
	/usr/bin/buildhash -s "${S}"/words-nl.ispell "${S}"/dutch.aff "${S}"/dutch.hash \
		|| die "buildhash failed"
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins dutch.aff dutch.hash
}
