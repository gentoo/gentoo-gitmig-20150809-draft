# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/openjade/openjade-1.3.1-r2.ebuild,v 1.3 2002/07/16 01:21:19 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Jade is an implemetation of DSSSL - an ISO standard for formatting SGML (and XML) documents"
SRC_URI="http://download.sourceforge.net/openjade/${P}.tar.gz"
HOMEPAGE="http://openjade.sourceforge.net"

DEPEND="virtual/glibc
	sys-devel/perl"

RDEPEND="virtual/glibc
	app-text/sgml-common"
KEYWORDS="x86 ppc"

src_compile() {

	#real weird setup here. we need to libtoolize to fix .la files.
	#
	#Azarah -- (7 April 2002)
	ln -s config/configure.in configure.in
	libtoolize --copy --force

	SGML_PREFIX=/usr/share/sgml

	./configure --host=${CHOST} \
		--prefix=/usr \
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

	insinto /usr/include/sp/generic
	doins generic/*.h

	insinto /usr/include/sp/include
	doins include/*.h

	insinto /usr/include/sp/lib
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

