# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/udunits/udunits-1.12.3.ebuild,v 1.4 2009/12/07 03:41:00 bicatali Exp $

inherit eutils flag-o-matic fortran perl-module toolchain-funcs

IUSE=""

S=${WORKDIR}/${P}/src
SP=${WORKDIR}/${P}/src/perl
DESCRIPTION="The UCAR/Unidata Units library"
HOMEPAGE="http://www.unidata.ucar.edu/packages/udunits/"
SRC_URI="ftp://unidata.ucar.edu/pub/udunits/udunits-${PV}.tar.Z"

SLOT="0"
LICENSE="UCAR-Unidata"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="dev-lang/perl
	sys-apps/sed"

RDEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:\${prefix}/etc:/etc:g" \
		-i -e "s:\${prefix}/man:\${prefix}/share/man:g" \
		-i -e "s:\${exec_prefix}/lib:\${exec_prefix}/$(get_libdir):g" \
		configure || die "sed 1 failed"
	epatch "${FILESDIR}/${P}-fixingtests.patch"
}

src_compile() {
	export CPPFLAGS="-Df2cFortran -D_POSIX_SOURCE"
	export CFLAGS="${CFLAGS}"
	export FC="${FORTRANC}"
	export CC="$(tc-getCC)"
	export CXX="$(tc-getCXX)"
	export LD_MATH="-lm"
	# This is needed for the perl shared object build
	append-flags -fPIC

	econf || die "econf failed"

	cd "${S}"/lib
		emake || die "emake lib failed"
	cd "${S}"

	cd "${S}"/perl
		perl-module_src_prep
		perl-module_src_compile
	cd "${S}"

	# random compile failures with -jN (when N > 1)
	emake -j1 || die "emake died"
}

src_test() {
	make check || die "make test failed"
}

src_install() {
	# The configure sucks, and so do the makefiles; this pretty much
	# needs to be done manually...
	dobin udunits/udunits
	dolib.a lib/libudunits.a port/misc/libudport.a
	doman udunits/udunits.1 lib/udunits.3 perl/udunitsperl.1

	insinto /etc
	doins lib/udunits.dat
	insinto /usr/include
	doins lib/{udunits.h,udunits.inc}
	# doman still doesn't put this in the right place
	insinto /usr/share/man/man3f
	doins lib/udunits.3f
	dodoc README RELEASE_NOTES

	fixlocalpod
	cd "${S}"/perl
		perl-module_src_install
	cd "${S}"

	# Clean up left-over cruft...  (yes, this is still needed)
	find "${D}" -type f -a \( -name perllocal.pod -o -name .packlist \
		-o \( -name '*.bs' -a -empty \) \) -exec rm -f {} ';'
	find "${D}" -type d -depth -exec rmdir {} 2>/dev/null ';'
	chmod -R u+w "${D}"/*
}

pkg_postinst() {
	ewarn "This package requires a Fortran compiler for maximum utility."
	ewarn "For now, make sure you have at least g77 for the f77 interface."
	ewarn "The internal configure should detect many f77 compilers, however,"
	ewarn "if you have the PG compiler you will need to change the above"
	ewarn "preprocessor macro to something like -Dpgifortran."
}
