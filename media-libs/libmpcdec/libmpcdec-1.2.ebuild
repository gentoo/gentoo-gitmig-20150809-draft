# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpcdec/libmpcdec-1.2.ebuild,v 1.3 2005/08/26 17:41:44 gustavoz Exp $

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://musepack.net/files/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE="doc static"

src_compile() {
	econf \
		$(use_enable static) \
		$(use_enable !static shared) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL README
	use doc && dohtml docs/html/*
}
