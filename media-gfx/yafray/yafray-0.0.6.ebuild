# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yafray/yafray-0.0.6.ebuild,v 1.3 2004/02/18 09:36:56 augustus Exp $

inherit gcc

DESCRIPTION="Yet Another Free Raytracer"
HOMEPAGE="http://www.yafray.org"
SRC_URI="http://www.coala.uniovi.es/~jandro/noname/downloads/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="media-libs/jpeg
		sys-libs/zlib"

DEPEND="${RDEPEND}
		=sys-devel/gcc-3*
		>=sys-apps/sed-4
		>=sys-devel/automake-1.7.2"

IUSE=""

export WANT_GCC_3="yes"
export WANT_AUTOMAKE="1.7"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s-O3 -fomit-frame-pointer -ffast-math${CXXFLAGS}" \
			src/Makefile.am || \
				die "sed src/Makefile.am failed"
aclocal
}

src_install() {
	einstall 			|| die
	dodoc AUTHORS 		|| die "dodoc failed"
	dohtml doc/doc.html || die "dohtml failed"
}
