# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.2.6-r1.ebuild,v 1.15 2007/01/05 07:09:32 flameeyes Exp $

inherit perl-module flag-o-matic eutils multilib

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/"
SRC_URI="http://people.ee.ethz.ch/~oetiker/webtools/${PN}/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE="doc perl tcl"

DEPEND="perl? ( dev-lang/perl )
	sys-apps/gawk
	>=sys-libs/zlib-1.2.1
	>=media-libs/freetype-2.1.5
	>=media-libs/libart_lgpl-2.3.16
	>=media-libs/libpng-1.2.5
	>=media-libs/gd-1.8.3
	>=dev-libs/cgilib-0.5"
RDEPEND="tcl? ( dev-lang/tcl )"

TCLVER=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:<rrd_\(.*\)>:"../../src/rrd_\1":g' \
		bindings/tcl/tclrrd.c || die "sed failed"
	sed -i -e 's:-lrrd_private:-ltcl -lrrd:' \
		bindings/tcl/Makefile.* || die "sed failed"
	sed -i -e 's:^\(LIBDIRS\s*= .*-L\)\.\./src/.libs:\1../../src/.libs/:' \
		bindings/tcl/Makefile.in || die "sed failed"
}

pkg_setup() {
	use perl && perl-module_pkg_setup
}

src_compile() {
	filter-mfpmath sse
	filter-flags -ffast-math

	local myconf
	myconf="--datadir=/usr/share --enable-shared"

	if use tcl ; then
		myconf="${myconf} --with-tcllib=/usr/$(get_libdir)"
	else
		myconf="${myconf} --without-tcllib"
	fi

	if use perl ; then
		econf ${myconf} --with-perl-options='PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}' || die "econf failed"
	else
		econf ${myconf} --disable-perl || die "econf failed"
	fi

	make || die "make failed"
}

src_install() {
	einstall || die

	# this package completely ignores mandir settings


	rm -rf ${D}/usr/doc
	rm -rf ${D}/usr/examples
	rm -rf ${D}/usr/shared

	if use doc ; then
		doman doc/*.1
		dohtml doc/*.html
		dodoc doc/*.pod
		dodoc doc/*.txt
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi


	if use perl ; then
		perlinfo
		mytargets="site-perl-install"
		perl-module_src_install || die

		# remove duplicate installation into /usr/lib/perl
		rm -Rf ${D}/usr/lib/perl
	fi

	if use tcl ; then
		mv ${S}/bindings/tcl/tclrrd.so ${S}/bindings/tcl/tclrrd${PV}.so
		insinto /usr/$(get_libdir)/tcl${TCL_VER}/tclrrd${PV}
		doins ${S}/bindings/tcl/tclrrd${PV}.so
		echo "package ifneeded Rrd ${PV} [list load [file join \$$dir .. tclrrd${PV}.so]]" \
			>> ${D}/usr/$(get_libdir)/tcl${TCL_VER}/tclrrd${PV}/pkgIndex.tcl
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
