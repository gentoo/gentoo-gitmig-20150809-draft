# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-7.ebuild,v 1.3 2009/08/22 12:16:57 ssuominen Exp $

EAPI=2
inherit eutils libtool toolchain-funcs

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/${PN}src.v${PV}.tar.gz
	mirror://gentoo/${P}-extra.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/libtool"

src_prepare() {
	epatch "${FILESDIR}"/${P}-maxmem_sysconf.patch
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		--enable-static \
		--enable-maxmem=64
}

src_compile() {
	emake || die "emake failed"
	tc-export CC
	emake -C "${WORKDIR}"/${P}-extra || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake -C "${WORKDIR}"/${P}-extra DESTDIR="${D}" \
		install || die "emake install failed"

	dodoc example.c README *.{log,txt} || die "dodoc failed"
}
