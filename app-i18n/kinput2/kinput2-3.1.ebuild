# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kinput2/kinput2-3.1.ebuild,v 1.6 2004/03/25 07:28:27 mr_bones_ Exp $

MY_P="${PN}-v${PV}"
DESCRIPTION="A Japanese input server which supports the XIM protocol"
SRC_URI="ftp://ftp.sra.co.jp/pub/x11/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.nec.co.jp/canna/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc"
IUSE="canna freewnn"

DEPEND="virtual/glibc
	canna? >=app-i18n/canna-3.5_beta2-r1
	freewnn? ( >=app-i18n/freewnn-1.1.1_alpha19 )
	!freewnn? ( >=app-i18n/canna-3.5_beta2-r1 )"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	# unpack the archive
	unpack ${A}

	# patch Kinput2.conf to ensure that files are installed into image dir
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die

	# hack to set define UseCanna, define UseWnn or both
	cp Kinput2.conf Kinput2.tmp
	use canna && sed -e "s:\/\* \#define UseCanna \*\/:\#define UseCanna:" Kinput2.tmp > Kinput2.conf
	cp Kinput2.conf Kinput2.tmp
	use freewnn && sed -e "s:\/\* \#define UseWnn \*\/:\#define UseWnn:" Kinput2.tmp > Kinput2.conf
	# default to UseCanna if we don't have freewnn in useflags
	cp Kinput2.conf Kinput2.tmp
	use freewnn || sed -e "s:\/\* \#define UseCanna \*\/:\#define UseCanna:" Kinput2.tmp > Kinput2.conf || die
}

src_compile() {
	# create a Makefile from Kinput2.conf
	xmkmf || die "xmkmf failed"
	make Makefiles || die "Makefile creation failed"

	# build Kinput2
	make depend || die "make depend failed"
	make || die "make failed"
}

src_install() {
	# install libs, executables, dictionaries
	make DESTDIR=${D} install || die "installation failed"

	# install docs
	dodoc README NEWS
}
