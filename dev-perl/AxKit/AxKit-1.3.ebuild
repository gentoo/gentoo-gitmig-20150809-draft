# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AxKit/AxKit-1.3.ebuild,v 1.3 2001/05/03 16:38:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Apache AxKit Perl Module"
SRC_URI="http://xml.sergeant.org/download/${A}"
HOMEPAGE="http://xml.sergeant.org/"

DEPEND=">=sys-devel/perl-5
	>=net-www/apache-ssl-1.3.17.2.8.0-r1
	>=dev-perl/libapreq-0.31
	>=dev-perl/Compress-Zlib-1.10
	>=dev-perl/Error-0.13
	>=dev-perl/HTTP-GHTTP-1.06
	>=dev-perl/Storable-1.0.7
	>=dev-perl/XML-XPath-1.04
	>=dev-perl/XML-Sablot-0.50"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile.PL Makefile.PL.orig
  sed -e "s:0\.31_03:0.31:" Makefile.PL.orig > Makefile.PL
}

src_compile() {

    perl Makefile.PL
    try make
    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    diropts -o nobody -g nogroup
    dodir /var/cache/axkit
    dodir /usr/local/httpd/htdocs/xslt
    insinto /etc/httpd
    doins ${FILESDIR}/httpd.axkit
    dodoc ChangeLog MANIFEST README* TODO

}



