# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/openjade/openjade-1.3.2-r1.ebuild,v 1.15 2004/04/08 22:55:20 vapier Exp $

inherit libtool sgml-catalog eutils

DESCRIPTION="Jade is an implemetation of DSSSL - an ISO standard for formatting SGML and XML documents"
HOMEPAGE="http://openjade.sourceforge.net"
SRC_URI="mirror://sourceforge/openjade/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ia64 x86 amd64 hppa ~ppc alpha sparc mips"
IUSE=""

RDEPEND="app-text/sgml-common
	>=app-text/opensp-1.5-r1"
DEPEND="dev-lang/perl
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	einfo "Patching msggen.pl for perl-5.6.*"
	epatch ${FILESDIR}/${P}-msggen.pl.patch
}

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
		CFLAGS="-O1 -pipe"
		CXXFLAGS="-O1 -pipe"
	fi

	ln -s config/configure.in configure.in
	elibtoolize

	SGML_PREFIX=/usr/share/sgml

	econf \
		--enable-http \
		--enable-default-catalog=/etc/sgml/catalog \
		--enable-default-search-path=/usr/share/sgml \
		--datadir=/usr/share/sgml/${P} || die

	emake || die
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
	dohtml doc/*.htm

	insinto /usr/share/doc/${PF}/jadedoc
	doins jadedoc/*.htm
	insinto /usr/share/doc/${PF}/jadedoc/images
	doins jadedoc/images/*
}

sgml-catalog_cat_include "/etc/sgml/${P}.cat" \
	"/usr/share/sgml/openjade-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/${P}.cat" \
	"/usr/share/sgml/openjade-${PV}/dsssl/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook.cat" \
	"/etc/sgml/${P}.cat"
