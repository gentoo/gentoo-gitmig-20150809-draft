# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r5.ebuild,v 1.10 2006/05/27 18:20:18 taviso Exp $

inherit flag-o-matic libtool eutils toolchain-funcs

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5.10-r4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# allow /etc/make.conf's HOST setting to apply
	sed -i 's/ltconfig.*/& $CHOST/' configure
	elibtoolize
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	tc-export CC RANLIB
	econf --enable-shared --enable-static || die "econf failed"

	if use ppc-macos ; then
		sed -i \
			-e '/^LIBTOOL =/s:=.*:=/usr/bin/glibtool:' \
			Makefile || die
	fi

	emake AR="$(tc-getAR) rc" || die "make failed"
}

src_install() {
	dodir /usr/{include,$(get_libdir),bin,share/man/man1}
	make \
		prefix="${D}"/usr \
		libdir="${D}"/usr/$(get_libdir) \
		mandir="${D}"/usr/share/man/man1 \
		install || die "make install"
	insinto /usr/include
	doins jpegint.h || die "jpeg headers"

	dodoc README install.doc usage.doc wizard.doc change.log \
		libjpeg.doc example.c structure.doc filelist.doc \
		coderules.doc
}
