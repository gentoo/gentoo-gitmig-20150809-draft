# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.1.ebuild,v 1.1 2005/01/29 21:29:50 chainsaw Exp $

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files.musepack.net/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT=${PV}
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="static"

src_compile() {
	ebegin "Rebuilding configure scripts"
	WANT_AUTOMAKE=1.7 ./autogen.sh > /dev/null
	eend
	econf `use_enable static` \
		`use_enable !static shared` || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
