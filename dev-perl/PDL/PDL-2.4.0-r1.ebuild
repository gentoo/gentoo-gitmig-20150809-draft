# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.4.0-r1.ebuild,v 1.4 2004/02/09 18:20:34 vapier Exp $

IUSE="opengl"

inherit perl-module

DESCRIPTION="PDL Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/PDL/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/PDL/${P}.readme"
SLOT="0"
LICENSE="Artistic as-is"
KEYWORDS="x86 amd64 ~ppc sparc alpha hppa"

newdepend ">=sys-libs/ncurses-5.2
	dev-perl/Filter
	|| ( dev-perl/File-Spec >=dev-lang/perl-5.8.0-r12 )
	dev-perl/Inline
	>=dev-perl/ExtUtils-F77-1.13
	dev-perl/Text-Balanced
	opengl? ( virtual/opengl virtual/glu )"

mydoc="DEPNDENCIES DEVELOPMENT MANIFEST* COPYING Release_Notes TODO"


src_unpack() {

	unpack ${A}

	#open gl does not work at the moment
	if [ "`use opengl`" ]
	then
		echo "OpenGL support is current disabled due to build issues"
		sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
			${FILESDIR}/perldl.conf > ${S}/perldl.conf
	else
		sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
			${FILESDIR}/perldl.conf > ${S}/perldl.conf
	fi
	if [ "`use hppa`"  -o "`use amd64`" ]
	then
	 cd ${S}/Lib/Slatec
	 cp Makefile.PL Makefile.PL.orig
	 sed -e "s/mycompiler -c -o/mycompiler -fPIC -c -o/" Makefile.PL.orig > Makefile.PL
	fi
}

src_install () {

	perl-module_src_install
	dodir /usr/share/doc/${PF}/html
	eval `perl '-V:version'`
	PERLVERSION=${version}
	mv ${D}/usr/lib/perl5/site_perl/${PERLVERSION}/${CHOST%%-*}-linux/PDL/HtmlDocs/PDL \
		${D}/usr/share/doc/${PF}/html

	mydir=${D}/usr/share/doc/${PF}/html/PDL

	for i in ${mydir}/* ${mydir}/IO/* ${mydir}/Fit/* ${mydir}/Pod/* ${mydir}/Graphics/*
	do
		dosed ${i/${D}}
	done

	dosed /usr/lib/perl5/site_perl/${PERLVERSION}/${CHOST%%-*}-linux/PDL/pdldoc.db
}
