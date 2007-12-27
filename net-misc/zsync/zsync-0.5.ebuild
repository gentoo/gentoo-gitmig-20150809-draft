# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zsync/zsync-0.5.ebuild,v 1.1 2007/12/27 14:46:58 armin76 Exp $

DESCRIPTION="Partial/differential file download client over HTTP which uses the rsync algorithm"
HOMEPAGE="http://zsync.moria.org.uk/"
SRC_URI="http://zsync.moria.org.uk/download/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	dobin zsync zsyncmake
	dodoc COPYING NEWS README
	doman doc/zsync.1 doc/zsyncmake.1
}
