# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.1.4.ebuild,v 1.3 2003/04/23 12:47:09 foser Exp $

IUSE="doc zlib prebuilt"

inherit eutils flag-o-matic

FT_SMOOTH_VER="20021210"

SPV="`echo ${PV} | cut -d. -f1,2`"
DESCRIPTION="A high-quality and portable font engine"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/ftdocs-${PV}.tar.bz2 )"

HOMEPAGE="http://www.freetype.org/"

SLOT="2"
LICENSE="FTL | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~arm"

DEPEND="virtual/glibc
	zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Slight Hint patch from Redhat
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.3-slighthint.patch
}

src_compile() {
	local myconf

	use zlib \
		&& myconf="${myconf} --with-zlib" \
		|| myconf="${myconf} --without-zlib" 

	use prebuilt || append-flags "${CFLAGS} -DTT_CONFIG_OPTION_BYTECODE_INTERPRETER"
	
	make CFG="--host=${CHOST} --prefix=/usr ${myconf}" || die
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
	dodoc docs/{CHANGES,*.txt,PATENTS,TODO}

	use doc && dohtml -r docs/*
}
