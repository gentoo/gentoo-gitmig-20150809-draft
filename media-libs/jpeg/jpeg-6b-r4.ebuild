# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r4.ebuild,v 1.2 2004/11/18 21:27:20 lu_zero Exp $

inherit gnuconfig flag-o-matic libtool eutils

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# allow /etc/make.conf's HOST setting to apply
	cd ${S}
	sed -i 's/ltconfig.*/& $CHOST/' configure
	gnuconfig_update
	uclibctoolize
	use ppc-macos && darwintoolize
	epatch ${FILESDIR}/${P}-pic.patch
}

src_compile() {
	replace-cpu-flags k6 k6-2 k6-3 i586
	econf --enable-shared --enable-static || die "econf failed"
	emake || die
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
