# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/openjade/openjade-1.3.1-r6.ebuild,v 1.5 2003/06/03 21:40:53 gmsoft Exp $

inherit libtool flag-o-matic 
inherit sgml-catalog


filter-flags -fno-exceptions

S=${WORKDIR}/${P}
DESCRIPTION="Jade is an implemetation of DSSSL - an ISO standard for formatting SGML and XML documents"
SRC_URI="mirror://sourceforge/openjade/${P}.tar.gz"
HOMEPAGE="http://openjade.sourceforge.net"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc
	dev-lang/perl"

RDEPEND="virtual/glibc
	app-text/sgml-common"

KEYWORDS="x86 ppc sparc alpha hppa"

src_compile() {
	# Please note!  Opts are disabled.  If you know what you're doing
	# feel free to remove this line.  It may cause problems with
	# docbook-sgml-utils among other things.
	CFLAGS=""
	CXXFLAGS=""

	# Default CFLAGS and CXXFLAGS is -O2 but this make openjade segfault
	# on hppa. Using -O1 works fine. So I force it here.
	if [ "${ARCH}" = "hppa" ]
	then
		CFLAGS="-O1"
		CXXFLAGS="-O1"
	fi

	ln -s config/configure.in configure.in
	elibtoolize

	SGML_PREFIX=/usr/share/sgml

	econf \
		--enable-http \
		--enable-default-catalog=/etc/sgml/catalog \
		--enable-default-search-path=/usr/share/sgml \
		--datadir=/usr/share/sgml/${P} || die
 
	make || die
}

src_install() {                               

	dodir /usr
	dodir /usr/lib
	make prefix=${D}/usr \
	  	datadir=${D}/usr/share/sgml/${P} \
		install || die
	
	dosym openjade  /usr/bin/jade
	dosym onsgmls   /usr/bin/nsgmls
	dosym osgmlnorm /usr/bin/sgmlnorm
	dosym ospam     /usr/bin/spam
	dosym ospent    /usr/bin/spent
	dosym osx       /usr/bin/sgml2xml

	SPINCDIR="/usr/include/OpenSP"
	insinto ${SPINCDIR}
	doins generic/*.h

	insinto ${SPINCDIR}
	doins include/*.h

	insinto ${SPINCDIR}
	doins lib/*.h

	insinto /usr/share/sgml/${P}/
	doins dsssl/builtins.dsl

	echo 'SYSTEM "builtins.dsl" "builtins.dsl"' > ${D}/usr/share/sgml/${P}/catalog
	insinto /usr/share/sgml/${P}/dsssl
	doins dsssl/{dsssl.dtd,style-sheet.dtd,fot.dtd}
	newins ${FILESDIR}/${P}.dsssl-catalog catalog
# Breaks sgml2xml among other things
#	insinto /usr/share/sgml/${P}/unicode
#	doins unicode/{catalog,unicode.sd,unicode.syn,gensyntax.pl}
	insinto /usr/share/sgml/${P}/pubtext
	doins pubtext/*

	dodoc COPYING NEWS README VERSION
	docinto html/doc
	dodoc doc/*.htm
	docinto html/jadedoc
	dodoc jadedoc/*.htm
	docinto html/jadedoc/images
	dodoc jadedoc/images/*

}

sgml-catalog_cat_include "/etc/sgml/${P}.cat" \
	"/usr/share/sgml/openjade-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/${P}.cat" \
	"/usr/share/sgml/openjade-${PV}/dsssl/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook.cat" \
	"/etc/sgml/${P}.cat"
