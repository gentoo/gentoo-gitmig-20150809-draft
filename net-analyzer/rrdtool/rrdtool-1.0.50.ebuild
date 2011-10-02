# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.0.50.ebuild,v 1.7 2011/10/02 00:00:11 radhermit Exp $

inherit perl-module flag-o-matic eutils

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://oss.oetiker.ch/rrdtool/"
SRC_URI="ftp://ftp.bit.nl/mirror/rrdtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE="perl tcl"

DEPEND="perl? ( dev-lang/perl )
	sys-apps/gawk
	>=media-libs/gd-1.8.3"
RDEPEND="tcl? ( dev-lang/tcl )"

TCL_VER=""

pkg_setup() {
	use perl && perl-module_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e 's/^LTCOMPILE = $(LIBTOOL) --tag=CC --mode=compile $(CC)/& -prefer-pic/' -i src/Makefile.in

	if [[ ! $(grep '^LTCOMPILE = $(LIBTOOL) --tag=CC --mode=compile $(CC) -prefer-pic' src/Makefile.in) ]]; then
		die "Makefile.in sed failed"
	fi
}

src_compile() {
	filter-mfpmath sse
	filter-flags -ffast-math

	local myconf
	myconf="${myconf} --datadir=/usr/share --enable-shared"

	if use tcl ; then
		myconf="${myconf} --with-tcllib=/usr/lib"
	else
		myconf="${myconf} --without-tcllib"
	fi

	if use perl; then
		econf ${myconf} --with-perl-options='PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}' || die "econf failed"

		# libraries without -fPIC? feh!
		for libdir in cgilib* gd* libpng* zlib*; do
			sed -i -e 's/^CFLAGS.*/& -fPIC/' ${libdir}/Makefile
		done
	else
		econf ${myconf} || die "econf failed"
	fi

	make || die "make failed"
}

src_install() {
	einstall || die

	# this package completely ignores mandir settings

	doman doc/*.1
	dohtml doc/*.html
	dodoc doc/*.pod
	dodoc doc/*.txt

	rm -rf "${D}"/usr/doc
	rm -rf "${D}"/usr/html
	rm -rf "${D}"/usr/man
	rm -rf "${D}"/usr/contrib
	rm -rf "${D}"/usr/examples

	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	insinto /usr/share/doc/${PF}/contrib
	doins contrib/*

	if use perl ; then
		perlinfo
		mytargets="site-perl-install"
		perl-module_src_install || die

		# remove duplicate installation into /usr/lib/perl
		rm -Rf "${D}"/usr/lib/perl
	fi

	if use tcl ; then
#		mv ${S}/tcl/tclrrd.so ${S}/tcl/tclrrd${PV}.so
#		insinto /usr/lib/tcl${TCL_VER}/tclrrd${PV}
#		doins ${S}/tcl/tclrrd${PV}.so
		echo "package ifneeded Rrd ${PV} [list load [file join \$$dir .. tclrrd${PV}.so]]" \
			>> "${D}"/usr/lib/tcl${TCL_VER}/tclrrd${PV}/pkgIndex.tcl
	fi

	dodoc COPY* CONTR* README TODO
}

pkg_preinst() {
	use perl && perl-module_pkg_preinst
}

pkg_postinst() {
	use perl && perl-module_pkg_postinst
}

pkg_prerm() {
	use perl && perl-module_pkg_prerm
}

pkg_postrm() {
	use perl && perl-module_pkg_postrm
}
