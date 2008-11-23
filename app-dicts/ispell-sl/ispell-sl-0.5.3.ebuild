# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-sl/ispell-sl-0.5.3.ebuild,v 1.5 2008/11/23 17:35:27 jer Exp $

inherit rpm multilib

DESCRIPTION="The Slovenian dictionary for ispell"
HOMEPAGE="http://nl.ijs.si/GNUsl/download/ispell/"
SRC_URI="http://nl.ijs.si/GNUsl/download/ispell/ispell-sl-0.5-3.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell"

S=${WORKDIR}

src_compile() {
	buildhash mte-sl.munched slovensko.aff slovensko.hash || die "Failed to create hash file"
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins slovensko.{aff,hash} || die
	dodoc README
}
