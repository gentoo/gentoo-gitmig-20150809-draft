# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yafray/yafray-0.0.6.ebuild,v 1.9 2004/10/27 23:14:12 lu_zero Exp $

inherit gcc eutils

DESCRIPTION="Yet Another Free Raytracer"
HOMEPAGE="http://www.yafray.org/"
SRC_URI="http://www.coala.uniovi.es/~jandro/noname/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ppc amd64"
IUSE=""

RDEPEND="media-libs/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3*
	>=sys-apps/sed-4
	>=sys-devel/automake-1.7.2"

export WANT_GCC_3="yes"
export WANT_AUTOMAKE="1.7"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/yafray-gcc34-fix.gz
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
