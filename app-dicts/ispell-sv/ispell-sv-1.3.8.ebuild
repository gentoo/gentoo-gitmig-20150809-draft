# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-sv/ispell-sv-1.3.8.ebuild,v 1.10 2008/11/01 11:47:43 pva Exp $

inherit multilib

DESCRIPTION="The Swedish dictionary for ispell"
HOMEPAGE="http://sv.speling.org"
SRC_URI="http://sv.speling.org/filer/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~mips ppc sparc x86"
IUSE=""

DEPEND="app-text/ispell"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins svenska.aff svenska.hash || die
	dodoc README contributors
}
