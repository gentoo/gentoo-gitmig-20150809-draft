# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.1.4-r1.ebuild,v 1.10 2004/03/19 07:56:03 mr_bones_ Exp $

IUSE="doc zlib bindist"

inherit eutils flag-o-matic

SPV="`echo ${PV} | cut -d. -f1,2`"
DESCRIPTION="A high-quality and portable font engine"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/ftdocs-${PV}.tar.bz2 )"

HOMEPAGE="http://www.freetype.org/"

SLOT="2"
LICENSE="FTL | GPL-2"
KEYWORDS="~x86 ppc ~sparc alpha hppa ia64 ~mips amd64"

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

	use bindist || append-flags "${CFLAGS} -DTT_CONFIG_OPTION_BYTECODE_INTERPRETER"

	make setup CFG="--host=${CHOST} --prefix=/usr ${myconf}" unix || die

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
