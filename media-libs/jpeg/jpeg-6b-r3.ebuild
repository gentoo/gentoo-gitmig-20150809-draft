# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r3.ebuild,v 1.27 2004/07/27 04:15:16 gongloo Exp $

inherit gnuconfig flag-o-matic

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ~macos"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	!macos? >=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# allow /etc/make.conf's HOST setting to apply
	cd ${S}
	sed -i 's/ltconfig.*/& $CHOST/' configure
	gnuconfig_update
}

src_compile() {
	replace-cpu-flags i586 k6 k6-2 k6-3

	econf --enable-shared --enable-static || die "econf failed"

	make || die
}

src_install() {
	dodir /usr/{include,lib,bin,share/man/man1}
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die

	dodoc README install.doc usage.doc wizard.doc change.log \
		libjpeg.doc example.c structure.doc filelist.doc \
		coderules.doc
}
