# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.2.ebuild,v 1.4 2001/04/24 00:07:03 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PDL Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/PDL/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/PDL/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/ncurses-5.2
	>=dev-perl/ExtUtils-F77-1.13
	opengl? ( virtual/opengl )"

src_unpack() {

  unpack ${A}
  cp ${FILESDIR}/perldl.conf ${S}
  if [ -z "`use opengl`" ]
  then
    sed -e "s:WITH_3D => undef:WITH_3D => 0:" ${FILESDIR}/perldl.conf > ${S}/perldl.conf
  fi

}

src_compile() {

    perl Makefile.PL 
    try make
    make test

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 install

    dodoc COPYING Changes DEPENDENCIES DEVELOPMENT README MANIFEST*
    dodoc Release_Notes TODO
    mv ${D}/usr/lib/perl5/site_perl/5.6.0/${CHOST%%-*}-linux/PDL/HtmlDocs ${D}/usr/doc/${P}/html
    mydir=${D}/usr/doc/${P}/html/PDL
    for i in ${mydir}/* ${mydir}/IO/* ${mydir}/Fit/* ${mydir}/Pod/* ${mydir}/Graphics/* 
    do
	dosed ${i/${D}}
    done
    dosed /usr/lib/perl5/site_perl/5.6.0/${CHOST%%-*}-linux/PDL/pdldoc.db 

}






