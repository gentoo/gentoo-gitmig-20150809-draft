# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgraphspace/kgraphspace-0.3.0_pre1.ebuild,v 1.1 2004/10/30 17:29:04 carlo Exp $

inherit kde

DESCRIPTION="A Disk space utility "
HOMEPAGE="http://kgraphspace.sourceforge.net"
SRC_URI="mirror://sourceforge/kgraphspace/${P//_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

S="$WORKDIR/${P//_/-}"

need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure.patch
}
