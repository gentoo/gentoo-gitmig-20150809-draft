# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.1.5-r1.ebuild,v 1.14 2004/08/01 19:18:28 solar Exp $

inherit eutils flag-o-matic gnuconfig

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2"

LICENSE="FTL | GPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 macos"
IUSE="zlib bindist cjk doc"

DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )"

src_unpack() {
	local SPV="`echo ${PV} | cut -d. -f1,2`"

	unpack ${A}

	cd ${S}
	# add autohint patch from http://www.kde.gr.jp/~akito/patch/freetype2/2.1.5/
	use cjk && epatch ${FILESDIR}/${SPV}/${P}-autohint-cjkfonts-20031105.patch

	gnuconfig_update ${S}
}

src_compile() {
	use bindist || append-flags -DTT_CONFIG_OPTION_BYTECODE_INTERPRETER

	make setup CFG="--host=${CHOST} --prefix=/usr `use_with zlib`" unix || die

	emake || die

	# Just a check to see if the Bytecode Interpreter was enabled ...
	if [ -z "`grep TT_Goto_CodeRange ${S}/objs/.libs/libfreetype.so`" ]
	then
		ewarn "Bytecode Interpreter is disabled."
	fi

}

src_install() {
	make prefix=${D}/usr install || die

	dodoc ChangeLog README
	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,*.txt,PATENTS,TODO}

	use doc && dohtml -r docs/*
}
