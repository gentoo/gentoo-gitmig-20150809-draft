# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zsync/zsync-0.3.2.ebuild,v 1.1 2005/03/23 19:01:45 karltk Exp $

DESCRIPTION="Partial/differential file download client over HTTP which uses the rsync algorithm"
HOMEPAGE="http://zsync.moria.org.uk/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="Artistic-2"
DEPEND="virtual/libc"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	dobin zsync zsyncmake
	dodoc COPYING NEWS README
	doman doc/zsync.1 doc/zsyncmake.1
}
