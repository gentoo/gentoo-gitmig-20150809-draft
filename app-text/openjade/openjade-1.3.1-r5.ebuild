# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/openjade/openjade-1.3.1-r5.ebuild,v 1.12 2004/07/14 02:20:13 agriffis Exp $

inherit libtool flag-o-matic


filter-flags -fno-exceptions

DESCRIPTION="Jade is an implemetation of DSSSL - an ISO standard for formatting SGML and XML documents"
SRC_URI="mirror://sourceforge/openjade/${P}.tar.gz"
HOMEPAGE="http://openjade.sourceforge.net"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/libc
	dev-lang/perl"

RDEPEND="virtual/libc
	app-text/sgml-common"

KEYWORDS="x86 ppc sparc alpha"
IUSE=""

src_compile() {
	# Please note!  Opts are disabled.  If you know what you're doing
	# feel free to remove this line.  It may cause problems with
	# docbook-sgml-utils among other things.
	CFLAGS=""
	CXXFLAGS=""

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

pkg_postinst() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
		install-catalog --add /etc/sgml/${P}.cat /usr/share/sgml/openjade-${PV}/catalog
		install-catalog --add /etc/sgml/${P}.cat /usr/share/sgml/openjade-${PV}/dsssl/catalog
#    install-catalog --add /etc/sgml/${P}.cat /usr/share/sgml/openjade-${PV}/unicode/catalog
		install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/${P}.cat
	fi
}

pkg_postrm() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
		if [ ! -e /usr/share/sgml/openjade-${PV}/catalog ] && \
		   [ -e /etc/sgml/${P}.cat ] ; then
			install-catalog --remove /etc/sgml/${P}.cat /usr/share/sgml/openjade-${PV}/catalog
		fi
		if [ ! -e /usr/share/sgml/openjade-${PV}/dsssl/catalog ] && \
		   [ -e /etc/sgml/${P}.cat ] ; then
			install-catalog --remove /etc/sgml/${P}.cat /usr/share/sgml/openjade-${PV}/dsssl/catalog
		fi
		if [ ! -e /usr/share/sgml/openjade-${PV}/unicode/catalog ] && \
		   [ -e /etc/sgml/${P}.cat ] ; then
			install-catalog --remove /etc/sgml/${P}.cat /usr/share/sgml/openjade-${PV}/unicode/catalog
		fi
		if [ ! -e /etc/sgml/${P}.cat ] ; then
			install-catalog --remove /etc/sgml/sgml-docbook.cat /etc/sgml/${P}.cat
		fi
	fi
}
