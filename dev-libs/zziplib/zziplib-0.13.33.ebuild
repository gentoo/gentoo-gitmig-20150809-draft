# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zziplib/zziplib-0.13.33.ebuild,v 1.2 2004/03/19 08:25:42 dholm Exp $

inherit fixheadtails

DESCRIPTION="Lightweight library used to easily extract data from files archived in a single zip file"
HOMEPAGE="http://zziplib.sourceforge.net/"
SRC_URI="mirror://sourceforge/zziplib/${P}.tar.bz2"

KEYWORDS="~x86 ~ppc"
LICENSE="LGPL-2.1 | MPL-1.1"
SLOT="0"

IUSE="sdl"

DEPEND="virtual/glibc
	dev-util/pkgconfig
	sys-libs/zlib
	sdl? ( >=media-libs/libsdl-1.2.6 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_all
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		`use_enable sdl` || die
	emake                || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README TODO || die "dodoc failed"
	dohtml docs/*               || die "dohtml failed"
}
