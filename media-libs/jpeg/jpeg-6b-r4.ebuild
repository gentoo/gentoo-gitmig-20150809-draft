# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r4.ebuild,v 1.6 2005/04/01 09:54:38 sekretarz Exp $

inherit flag-o-matic libtool eutils toolchain-funcs

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/libtool-1.5.10-r4"

src_unpack() {
	unpack ${A}

	# allow /etc/make.conf's HOST setting to apply
	cd ${S}
	sed -i 's/ltconfig.*/& $CHOST/' configure
	uclibctoolize
	use ppc-macos && darwintoolize
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	replace-cpu-flags k6 k6-2 k6-3 i586
	econf --enable-shared --enable-static || die "econf failed"
	if use ppc-macos; then
		cd ${S}
		sed -i -e 's:LIBTOOL = libtool:LIBTOOL = /usr/bin/glibtool:' Makefile
	fi
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR) rc" \
		AR2="$(tc-getRANLIB)" \
		|| die "make failed"
}

src_install() {
	dodir /usr/{include,$(get_libdir),bin,share/man/man1}
	make \
		prefix=${D}/usr \
		libdir=${D}/usr/$(get_libdir) \
		mandir=${D}/usr/share/man/man1 \
		install || die
	insinto /usr/include
	doins jpegint.h

	if ! use ppc-macos ; then
		dosym libjpeg.so.62.0.0 /usr/$(get_libdir)/libjpeg.so.62
		dosym libjpeg.so.62.0.0 /usr/$(get_libdir)/libjpeg.so
	fi

	dodoc README install.doc usage.doc wizard.doc change.log \
		libjpeg.doc example.c structure.doc filelist.doc \
		coderules.doc
}
