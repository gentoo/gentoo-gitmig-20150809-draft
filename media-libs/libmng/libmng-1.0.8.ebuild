# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-1.0.8.ebuild,v 1.4 2004/10/31 22:40:02 kito Exp $

DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
HOMEPAGE="http://www.libmng.com/"
SRC_URI="http://download.sourceforge.net/libmng/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~ppc-macos"
IUSE=""

RDEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}
	>=media-libs/lcms-1.0.8"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp libmng_types.h libmng_types.h.orig

	sed 's:\(#include\) "lcms.h":\1 <lcms/lcms.h>:' \
		libmng_types.h.orig > libmng_types.h
	bash ${S}/autogen.sh
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc Changes README*
	dodoc doc/doc.readme doc/libmng.txt
	doman doc/man/*
	dohtml -r doc
}