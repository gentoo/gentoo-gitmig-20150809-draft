# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yafray/yafray-0.0.6.ebuild,v 1.14 2005/09/17 03:11:36 vanquirius Exp $

inherit eutils

DESCRIPTION="Yet Another Free Raytracer"
HOMEPAGE="http://www.yafray.org/"
SRC_URI="http://www.coala.uniovi.es/~jandro/noname/downloads/${P}.tar.gz
	mirror://gentoo/${PN}-gcc34-fix.gz
	http://dev.gentoo.org/~vanquirius/files/${PN}-gcc34-fix.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND="media-libs/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3
	>=sys-apps/sed-4
	>=sys-devel/automake-1.7.2"

export WANT_AUTOMAKE="1.7"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}/${PN}-gcc34-fix"
	cd ${S}

	sed -i \
		-e "s-O3 -fomit-frame-pointer -ffast-math${CXXFLAGS}" \
			src/Makefile.am || \
				die "sed src/Makefile.am failed"
	aclocal
	libtoolize --copy --force
}

src_install() {
	einstall || die
	dodoc AUTHORS || die "dodoc failed"
	dohtml doc/doc.html || die "dohtml failed"
}
