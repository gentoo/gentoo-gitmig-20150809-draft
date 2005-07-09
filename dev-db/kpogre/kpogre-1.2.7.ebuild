# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kpogre/kpogre-1.2.7.ebuild,v 1.5 2005/07/09 15:40:51 agriffis Exp $

inherit kde eutils

DESCRIPTION="PostgreSQL graphical frontend for KDE"
HOMEPAGE="http://kpogre.sourceforge.net/"
SRC_URI="mirror://sourceforge/kpogre/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="arts"

DEPEND="dev-db/postgresql
	>=dev-libs/libpqxx-2.2.1"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure-arts.patch
}
