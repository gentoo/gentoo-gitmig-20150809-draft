# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-1.0.8-r1.ebuild,v 1.11 2005/08/24 17:38:49 agriffis Exp $

DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
HOMEPAGE="http://www.libmng.com/"
SRC_URI="http://download.sourceforge.net/libmng/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 mips ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4
	>=media-libs/lcms-1.0.8"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	!ppc-macos? ( =sys-devel/automake-1.9* )"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's:\(#include\) "lcms.h":\1 <lcms/lcms.h>:' libmng_types.h
	sed -i -e 's:lcms\.h:lcms/lcms\.h:' makefiles/configure.in
}

src_compile() {
	ln -s makefiles/configure.in .
	ln -s makefiles/Makefile.am .

	export WANT_AUTOMAKE="1.9"
	autoreconf --force --install

	econf --with-lcms || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc CHANGES README*
	dodoc doc/doc.readme doc/libmng.txt
	doman doc/man/*
}
