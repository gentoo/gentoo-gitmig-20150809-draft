# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-1.0.8.ebuild,v 1.5 2005/04/22 01:43:38 flameeyes Exp $

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
	sys-devel/autoconf
	!ppc-macos? ( =sys-devel/automake-1.9* )
	>=media-libs/lcms-1.0.8"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's:\(#include\) "lcms.h":\1 <lcms/lcms.h>:' \
		libmng_types.h

	sh autogen.sh
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc Changes README* doc/doc.readme doc/libmng.txt
	doman doc/man/*
	dohtml -r doc
}
