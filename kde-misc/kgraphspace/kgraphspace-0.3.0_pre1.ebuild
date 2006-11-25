# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgraphspace/kgraphspace-0.3.0_pre1.ebuild,v 1.5 2006/11/25 04:34:56 masterdriverz Exp $

inherit kde eutils

DESCRIPTION="A Disk space utility "
HOMEPAGE="http://kgraphspace.sourceforge.net"
SRC_URI="mirror://sourceforge/kgraphspace/${P//_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

S="$WORKDIR/${P//_/-}"

need-kde 3

DEPEND="|| ( kde-base/libkonq kde-base/kdebase )"

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure.patch
}
