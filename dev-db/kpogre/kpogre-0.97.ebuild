# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kpogre/kpogre-0.97.ebuild,v 1.1 2004/04/26 08:38:11 nakano Exp $

inherit kde-base
need-kde 3

DESCRIPTION="PostgreSQL grafical frontend for KDE"
HOMEPAGE="http://kpogre.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

DEPEND="dev-db/postgresql
	>=dev-libs/libpqxx-2.2.1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

