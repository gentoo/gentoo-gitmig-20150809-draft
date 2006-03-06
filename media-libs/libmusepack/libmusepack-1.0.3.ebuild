# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.0.3.ebuild,v 1.4 2006/03/06 16:10:57 flameeyes Exp $

IUSE=""

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.saunalahti.fi/grimmel/musepack.net/source/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
