# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.4.2-r1.ebuild,v 1.1 2006/04/26 22:18:50 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="PDL Perl Module"
HOMEPAGE="http://search.cpan.org/~csoe/${P}/"
SRC_URI="mirror://cpan/authors/id/C/CS/CSOE/${P}.tar.gz"

LICENSE="Artistic as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="opengl badval"

DEPEND=">=sys-libs/ncurses-5.2
	perl-core/Filter
	|| ( perl-core/File-Spec >=dev-lang/perl-5.8.0-r12 )
	dev-perl/Inline
	>=dev-perl/ExtUtils-F77-1.13
	perl-core/Text-Balanced
	opengl? ( virtual/opengl virtual/glu )
	dev-perl/Term-ReadLine-Perl
	>=sys-apps/sed-4"

mydoc="DEPENDENCIES DEVELOPMENT MANIFEST* Release_Notes TODO"


pkg_setup() {
	echo ""
	einfo "If you want GSL library support in PDL,"
	einfo "you need to emerge sci-libs/gsl first."
	echo ""
	epause 2
}

src_unpack() {
	unpack ${A}

	cd ${S}; epatch ${FILESDIR}/PDL-2.4.2-makemakerfix.patch
	#open gl does not work at the moment
	if ! use opengl ; then
		sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
			${FILESDIR}/perldl.conf > ${S}/perldl.conf
	fi

	if use badval ; then
		sed -i -e "s:WITH_BADVAL => 0:WITH_BADVAL => 1:" \
			${S}/perldl.conf
	fi


	# Unconditional -fPIC for the lib (#55238)
	sed -i -e "s/mycompiler -c -o/mycompiler -fPIC -c -o/" ${S}/Lib/Slatec/Makefile.PL
}

src_install() {
	perl-module_src_install
	dodir /usr/share/doc/${PF}/html
	eval `perl '-V:version'`
	PERLVERSION=${version}
	eval `perl '-V:archname'`
	ARCHVERSION=${archname}
	mv ${D}/usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/HtmlDocs/PDL \
		${D}/usr/share/doc/${PF}/html

	mydir=${D}/usr/share/doc/${PF}/html/PDL

	for i in ${mydir}/* ${mydir}/IO/* ${mydir}/Fit/* ${mydir}/Pod/* ${mydir}/Graphics/*
	do
		dosed ${i/${D}}
	done
	cp ${S}/Doc/scantree.pl ${D}/usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/
	cp ${S}/Doc/mkhtmldoc.pl ${D}/usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/
}

pkg_postinst() {
	perl /usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/scantree.pl
	einfo "Building perldl.db done. You can recreate this at any time"
	einfo "by running"
	einfo "perl /usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/scantree.pl"
	epause 3
	einfo "PDL requires that glx and dri support be enabled in"
	einfo "your X configuration for certain parts of the graphics"
	einfo "engine to work. See your X's documentation for futher"
	einfo "information."
}
