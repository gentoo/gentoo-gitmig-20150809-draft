# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.4.3.ebuild,v 1.5 2007/03/26 17:43:29 armin76 Exp $

inherit perl-module eutils multilib

DESCRIPTION="PDL Perl Module"
HOMEPAGE="http://search.cpan.org/~csoe/"
SRC_URI="mirror://cpan/authors/id/C/CS/CSOE/${P}.tar.gz"

LICENSE="Artistic as-is"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~s390 ~sh ~sparc ~x86"
IUSE="opengl badval"

DEPEND=">=sys-libs/ncurses-5.2
	perl-core/Filter
	virtual/perl-File-Spec
	dev-perl/Inline
	dev-perl/Astro-FITS-Header
	>=dev-perl/ExtUtils-F77-1.13
	virtual/perl-Text-Balanced
	opengl? ( virtual/opengl virtual/glu )
	dev-perl/Term-ReadLine-Perl
	>=sys-apps/sed-4"

mydoc="DEPENDENCIES DEVELOPMENT MANIFEST* Release_Notes TODO"

#SRC_TEST="do"


pkg_setup() {
	echo ""
	elog "If you want GSL library support in PDL,"
	elog "you need to emerge sci-libs/gsl first."
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
	mv ${D}/usr/$(get_libdir)/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/HtmlDocs/PDL \
		${D}/usr/share/doc/${PF}/html

	mydir=${D}/usr/share/doc/${PF}/html/PDL

	for i in ${mydir}/* ${mydir}/IO/* ${mydir}/Fit/* ${mydir}/Pod/* ${mydir}/Graphics/*
	do
		dosed ${i/${D}}
	done
	cp ${S}/Doc/scantree.pl ${D}/usr/$(get_libdir)/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/
	cp ${S}/Doc/mkhtmldoc.pl ${D}/usr/$(get_libdir)/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/
}

pkg_postinst() {
	perl /usr/$(get_libdir)/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/scantree.pl
	elog "Building perldl.db done. You can recreate this at any time"
	elog "by running"
	elog "perl /usr/$(get_libdir)/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/PDL/Doc/scantree.pl"
	epause 3
	elog "PDL requires that glx and dri support be enabled in"
	elog "your X configuration for certain parts of the graphics"
	elog "engine to work. See your X's documentation for futher"
	elog "information."
}
