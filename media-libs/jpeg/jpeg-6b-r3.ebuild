# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r3.ebuild,v 1.21 2004/03/22 21:00:21 seemant Exp $

inherit gnuconfig flag-o-matic

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"
HOMEPAGE="http://www.ijg.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ppc64"

RDEPEND="virtual/glibc"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# allow /etc/make.conf's HOST setting to apply
	cd ${S}
	sed -i 's/ltconfig.*/& $CHOST/' configure
	use alpha && gnuconfig_update
	use hppa && gnuconfig_update
	use amd64 && gnuconfig_update
	use ia64 && gnuconfig_update
	use ppc64 && gnuconfig_update
}

src_compile() {
	replace-flags k6-3 i586
	replace-flags k6-2 i586
	replace-flags k6 i586

	econf --enable-shared --enable-static

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
