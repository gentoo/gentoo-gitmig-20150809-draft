# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgraphspace/kgraphspace-0.3.0_pre1.ebuild,v 1.8 2008/03/27 17:27:25 armin76 Exp $

inherit kde eutils

DESCRIPTION="A Disk space utility "
HOMEPAGE="http://kgraphspace.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P//_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

S="$WORKDIR/${P//_/-}"

DEPEND="|| ( =kde-base/kdebase-3.5* =kde-base/libkonq-3.5* )"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	use arts || epatch "${FILESDIR}"/${P}-configure.patch
}
