# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tkinfo/tkinfo-2.6.ebuild,v 1.7 2005/01/01 16:38:37 eradicator Exp $

DESCRIPTION="Info Browser in TK"
SRC_URI="http://math-www.uni-paderborn.de/~axel/tkinfo/${P}.tar.gz"
HOMEPAGE="http://math-www.uni-paderborn.de/~axel/tkinfo/"

KEYWORDS="x86 sparc ppc hppa alpha"
IUSE=""
LICENSE="freedist"
SLOT="0"

RDEPEND=">=dev-lang/tk-8.0.5"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "1 s:^.*:#!/usr/bin/wish:" tkinfo || \
			die "sed tkinfo failed"
}

src_install () {
	dobin tkinfo
	doman tkinfo.1
	dodoc README
}
