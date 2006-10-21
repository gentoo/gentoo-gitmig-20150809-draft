# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.2.11-r2.ebuild,v 1.7 2006/10/21 18:43:30 dertobi123 Exp $

inherit perl-module flag-o-matic gnuconfig eutils multilib

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/"
SRC_URI="http://people.ee.ethz.ch/~oetiker/webtools/${PN}/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ppc ppc64 ~sparc ~x86"
IUSE="doc perl python tcltk"

RDEPEND="tcltk? ( dev-lang/tcl )
	>=sys-libs/zlib-1.2.1
	>=media-libs/freetype-2.1.5
	>=media-libs/libart_lgpl-2.3.16
	>=media-libs/libpng-1.2.5"

DEPEND="${RDEPEND}
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	sys-apps/gawk
	>=dev-libs/cgilib-0.5"

TCLVER=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:<rrd_\(.*\)>:"../../src/rrd_\1":g' \
		bindings/tcl/tclrrd.c || die "sed failed"
	sed -i -e 's:-lrrd_private:-ltcl -lrrd:' \
		bindings/tcl/Makefile.* || die "sed failed"
	sed -i -e 's:python_PROGRAMS:pyexec_PROGRAMS:' \
		bindings/python/Makefile.* || die "sed failed"
	sed -i -e 's:\$TCL_PACKAGE_PATH:${TCL_PACKAGE_PATH%% *}:' \
		configure.ac
	libtoolize --copy --force
	autoreconf
}

pkg_setup() {
	use perl && perl-module_pkg_setup
}

src_compile() {
	filter-mfpmath sse
	filter-flags -ffast-math

	local myconf
	myconf="--datadir=/usr/share --enable-shared"

	use tcltk \
		&& myconf="${myconf} --with-tcllib=/usr/$(get_libdir)" \
		|| myconf="${myconf} --without-tcllib"

	use python || myconf="${myconf} --disable-python"

	if use perl ; then
		econf ${myconf} --with-perl-options='PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}' || \
			die "econf failed"
	else
		econf ${myconf} --disable-perl || die "econf failed"
	fi

	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	rm -fr "${D}"/usr/examples
	rm -fr "${D}"/usr/shared

	if use doc ; then
		dohtml doc/*.html
		dodoc doc/*.pod
		dodoc doc/*.txt
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
		insinto /usr/share/doc/${PF}/contrib
		doins contrib/*
	fi

	if use perl ; then
		perlinfo
		mytargets="site-perl-install"
		perl-module_src_install || die

		# remove duplicate installation into /usr/lib/perl
		rm -Rf "${D}"/usr/lib/perl
	fi

	if use tcltk ; then
		mv "${S}"/bindings/tcl/tclrrd.so "${S}"/bindings/tcl/tclrrd${PV}.so
		insinto /usr/$(get_libdir)/tcl${TCL_VER}/tclrrd${PV}
		doins "${S}"/bindings/tcl/tclrrd${PV}.so
		echo "package ifneeded Rrd ${PV} [list load [file join \$$dir .. tclrrd${PV}.so]]" \
			>> "${D}"/usr/$(get_libdir)/tcl${TCL_VER}/tclrrd${PV}/pkgIndex.tcl
	fi

	dodoc CONTRIBUTORS README TODO
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
