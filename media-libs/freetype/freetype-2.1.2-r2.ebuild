# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.1.2-r2.ebuild,v 1.6 2003/02/28 15:23:40 gmsoft Exp $

IUSE="doc"

inherit eutils

SPV="`echo ${PV} | cut -d. -f1,2`"
S="${WORKDIR}/${P}"
DESCRIPTION="A high-quality and portable font engine"
SRC_URI="mirror://sourceforge/freetype/${P}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/ftdocs-${PV}.tar.bz2 )"
HOMEPAGE="http://www.freetype.org/"

SLOT="2"
LICENSE="FTL | GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# Enable hinting for truetype fonts
#	cd ${S}/include/freetype/config
#	cp ftoption.h ftoption.h.orig
#	sed -e 's:#undef  TT_CONFIG_OPTION_BYTECODE_INTERPRETER:#define TT_CONFIG_OPTION_BYTECODE_INTERPRETER:' \
#		ftoption.h.orig > ftoption.h

	# Some Redhat patches.
	cd ${S}
	# Enable BCI, just a patch for above sed.
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.1-enable-ft2-bci.patch
	# Fix bug in PS hinter
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.1-primaryhints.patch
	# Adds FT_Set_Hint_Flags
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.2-slighthint.patch
	# Support the Type1 BlueFuzz value
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.2-bluefuzz.patch
	# Another PS hinter bug fix
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.2-stdw.patch
	# Fix from CVS for outline transformation
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.2-transform.patch
	# Backport of autohinter improvements from CVS
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.2-autohint.patch
	# Fix metrics for PCF fonts
	epatch ${FILESDIR}/${SPV}/${PN}-2.1.2-leftright.patch
}


src_compile() {
	make CFG="--host=${CHOST} --prefix=/usr" || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc ChangeLog README 
	dodoc docs/{BUGS,BUILD,CHANGES,*.txt,PATENTS,readme.vms,TODO}

	use doc && dohtml -r docs/*
}

