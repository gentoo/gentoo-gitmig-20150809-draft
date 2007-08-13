# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.2.23-r1.ebuild,v 1.9 2007/08/13 21:25:48 dertobi123 Exp $

inherit autotools eutils flag-o-matic multilib perl-module

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://oss.oetiker.ch/rrdtool/"
SRC_URI="http://oss.oetiker.ch/rrdtool/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ia64 ~mips ppc ppc64 ~sh sparc ~x86"
IUSE="doc perl python ruby rrdcgi tcl uclibc"

RDEPEND="tcl? ( dev-lang/tcl )
	>=sys-libs/zlib-1.2.1
	>=media-libs/freetype-2.1.5
	>=media-libs/libart_lgpl-2.3.16
	>=media-libs/libpng-1.2.5
	rrdcgi? ( >=dev-libs/cgilib-0.5 )
	ruby? ( !dev-ruby/ruby-rrd )"

DEPEND="${RDEPEND}
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	sys-apps/gawk"

TCLVER=""

HTMLDOC_DIR="${PF}/html"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2.15-newstyle-resize.patch
	epatch "${FILESDIR}"/${P}-tclbindings.patch
	use ruby && epatch "${FILESDIR}"/${P}-ruby-binding-compile.patch
	use ruby && epatch "${FILESDIR}"/${P}-ruby-binding-configure.patch
	use uclibc && epatch "${FILESDIR}"/${PN}-1.2.15-no-man.patch
	eautoreconf
}

pkg_setup() {
	use perl && perl-module_pkg_setup
}

src_compile() {
	filter-mfpmath sse
	filter-flags -ffast-math

	export RRDDOCDIR=/usr/share/doc/${PF}

	econf $(use_enable rrdcgi) \
		$(use_enable ruby) \
		$(use_enable perl) \
		--with-perl-options='PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}' \
		$(use_enable tcl) \
		$(use_with tcl tcllib /usr/$(get_libdir)) \
		$(use_enable python) || die "econf failed."

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if ! use doc ; then
		rm -rf "${D}"/usr/share/doc/${PF}/{html,txt}
	fi

	if use perl ; then
		perlinfo
		mytargets="site-perl-install"
		perl-module_src_install || die
	fi

	dodoc CHANGES CONTRIBUTORS NEWS README THREADS TODO
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
