# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zziplib/zziplib-0.13.26.ebuild,v 1.1 2004/02/11 20:18:05 mr_bones_ Exp $

inherit fixheadtails

DESCRIPTION="Lightweight library used to easily extract data from files archived in a single zip file"
HOMEPAGE="http://zziplib.sourceforge.net/"
SRC_URI="mirror://sourceforge/zziplib/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="LGPL-2.1 | MPL-1.1"
SLOT="0"

IUSE="sdl"

DEPEND="sys-libs/zlib
	sdl? ( >=media-libs/libsdl-1.2.5 )"

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
