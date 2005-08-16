# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zziplib/zziplib-0.13.38.ebuild,v 1.2 2005/08/16 03:59:51 weeve Exp $

inherit fixheadtails

DESCRIPTION="Lightweight library used to easily extract data from files archived in a single zip file"
HOMEPAGE="http://zziplib.sourceforge.net/"
SRC_URI="mirror://sourceforge/zziplib/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="sdl"

RDEPEND="virtual/libc
	sys-libs/zlib
	sdl? ( >=media-libs/libsdl-1.2.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	ht_fix_all
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable sdl) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README TODO
	dohtml docs/*
}
