# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.4.0-r2.ebuild,v 1.7 2004/11/07 09:57:43 kumba Exp $

IUSE="opengl"

inherit perl-module eutils

DESCRIPTION="PDL Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/PDL/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/PDL/${P}.readme"
SLOT="0"
LICENSE="Artistic as-is"
KEYWORDS="x86 ~ppc sparc alpha hppa mips amd64"

DEPEND=">=sys-libs/ncurses-5.2
	dev-perl/Filter
	|| ( dev-perl/File-Spec >=dev-lang/perl-5.8.0-r12 )
	dev-perl/Inline
	>=dev-perl/ExtUtils-F77-1.13
	dev-perl/Text-Balanced
	opengl? ( virtual/opengl virtual/glu )
	>=sys-apps/sed-4"

mydoc="DEPENDENCIES DEVELOPMENT MANIFEST* COPYING Release_Notes TODO"


pkg_setup() {
	echo ""
	einfo "If you want GSL library support in PDL,"
	einfo "you need to emerge dev-libs/gsl first."
	echo ""
	epause 5
}
src_unpack() {

	unpack ${A}

	#open gl does not work at the moment
	if use opengl
	then
		echo "OpenGL support is current disabled due to build issues"
		sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
			${FILESDIR}/perldl.conf > ${S}/perldl.conf
	else
		sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
			${FILESDIR}/perldl.conf > ${S}/perldl.conf
	fi

	# Unconditional -fPIC for the lib (#55238)
	sed -i -e "s/mycompiler -c -o/mycompiler -fPIC -c -o/" ${S}/Lib/Slatec/Makefile.PL

	# The below patch was supplied by Karl Steddom <k-steddom@tamu.edu>
	# in bug 33936 to correct PDL's inability to detect GSL libraries
	# correctly. 
	# -mcummings
	cd ${S}
	epatch ${FILESDIR}/gsl.patch || die
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
