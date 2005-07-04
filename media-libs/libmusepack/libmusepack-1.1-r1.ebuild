# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.1-r1.ebuild,v 1.3 2005/07/04 20:10:26 gustavoz Exp $

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files.musepack.net/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="static"

src_compile() {
	ebegin "Rebuilding configure scripts"
	WANT_AUTOMAKE=1.7 ./autogen.sh > /dev/null
	eend
	econf \
		$(use_enable static) \
		$(use_enable !static shared) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
