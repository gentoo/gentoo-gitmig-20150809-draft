# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/udunits/udunits-1.12.1.ebuild,v 1.5 2004/12/11 18:52:14 kloeri Exp $

inherit eutils flag-o-matic

IUSE=""

S=${WORKDIR}/${P}/src
SP=${WORKDIR}/${P}/src/perl
DESCRIPTION="The UCAR/Unidata Units library"
HOMEPAGE="http://www.unidata.ucar.edu/packages/udunits/"
SRC_URI="ftp://unidata.ucar.edu/pub/udunits/udunits-${PV}.tar.Z"

SLOT="0"
LICENSE="UCAR-Unidata"
KEYWORDS="x86 ~amd64 ~ppc ~sparc alpha ~mips ~hppa"

DEPEND="dev-lang/perl
	sys-apps/sed"

RDEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/udunits_customize.patch || die "epatch failed"
}

src_compile() {
	export CPPFLAGS="-Df2cFortran -D_POSIX_SOURCE"
	append-flags -fPIC
	econf || die "econf failed"

	cd lib
	emake || die
	cd ..

	cd perl
	perl Makefile.PL PREFIX=${D}/usr
	cd ..

	emake || die
	emake test || die
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

pkg_postinst() {
	ewarn "This package requires a Fortran compiler for maximum utility."
	ewarn "For now, make sure you have at least g77 for the f77 interface."
	ewarn "The internal configure should detect many f77 compilers, however,"
	ewarn "if you have the PG compiler you will need to change the above"
	ewarn "preprocessor macro to something like -Dpgifortran."
}
