# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/udunits/udunits-1.12.0.ebuild,v 1.9 2004/10/30 15:34:37 ribosome Exp $

inherit eutils

# This is the Unidata Units library, which supports conversion of unit 
# specifications between formatted and binary forms, arithmetic 
# manipulation of unit specifications, and conversion of values between 
# compatible scales of measurement.

#inherit perl-module

IUSE=""
S=${WORKDIR}/${P}/src
SP=${WORKDIR}/${P}/src/perl
DESCRIPTION="The UCAR/Unidata Units library"
HOMEPAGE="http://www.unidata.ucar.edu/packages/udunits/"
SRC_URI="ftp://unidata.ucar.edu/pub/udunits/udunits-${PV}.tar.Z"

SLOT="0"
LICENSE="UCAR-Unidata"
KEYWORDS="x86 ~ppc ~sparc alpha ~mips ~hppa"

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/udunits_configure_in.patch
	epatch ${FILESDIR}/udunits_lib_make.patch
	epatch ${FILESDIR}/udunits_master_mk.patch
}

src_compile() {
	export CPPFLAGS=-Df2cFortran
	econf || die "econf failed"
	cd perl
	perl Makefile.PL PREFIX=${D}/usr
	cd ..
	make ld_math=-lm || die
#	make test || die
}

src_install() {
	sed "s?/usr?${D}/usr?" Makefile > Makefile.install
	emake -f Makefile.install install
	dodir /etc /usr/share/man/man3 /usr/share/man/man3f
	insinto /etc
	insopts -m 644
	doins lib/udunits.dat
	insinto /usr/share/man/man3
	doins lib/udunits.3
	insinto /usr/share/man/man3f
	doins lib/udunits.3f

	cd perl
	make PREFIX=${D}/usr install INSTALLSITEMAN1DIR=${D}/usr/share/man/man1
	cd ..
	find ${D} -type f -a \( -name perllocal.pod -o -name .packlist \
	    -o \( -name '*.bs' -a -empty \) \) -exec rm -f {} ';'
	find ${D} -type d -depth -exec rmdir {} 2>/dev/null ';'
	chmod -R u+w ${D}/*

	dodoc COPYRIGHT README RELEASE_NOTES VERSION CUSTOMIZE INSTALL
}

