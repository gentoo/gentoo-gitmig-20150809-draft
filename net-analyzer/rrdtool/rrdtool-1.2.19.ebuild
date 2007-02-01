# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.2.19.ebuild,v 1.1 2007/02/01 14:48:52 jokey Exp $

inherit autotools eutils flag-o-matic multilib perl-module

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/"
SRC_URI="http://people.ee.ethz.ch/~oetiker/webtools/${PN}/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc perl python rrdcgi tcl uclibc"

RDEPEND="tcl? ( dev-lang/tcl )
	>=sys-libs/zlib-1.2.1
	>=media-libs/freetype-2.1.5
	>=media-libs/libart_lgpl-2.3.16
	>=media-libs/libpng-1.2.5
	rrdcgi? ( >=dev-libs/cgilib-0.5 )"

DEPEND="${RDEPEND}
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	sys-apps/gawk"

TCLVER=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2.15-newstyle-resize.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-tclbindings.patch
	use uclibc && epatch "${FILESDIR}"/${PN}-1.2.15-no-man.patch
	eautoreconf
}

pkg_setup() {
	use perl && perl-module_pkg_setup
}

src_compile() {
	filter-mfpmath sse
	filter-flags -ffast-math

	local myconf
	myconf="--datadir=/usr/share --enable-shared $(use_enable rrdcgi)"

	use python || myconf="${myconf} --disable-python"

	if use tcl ; then
		myconf="${myconf} --with-tcllib=/usr/$(get_libdir)"
	else
		myconf="${myconf} --disable-tcl"
	fi

	if use perl ; then
		econf ${myconf} --with-perl-options='PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}' || die "econf failed"
	else
		econf ${myconf} --disable-perl || die "econf failed"
	fi

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	rm -fr "${D}"/usr/examples
	rm -fr "${D}"/usr/shared

	if use doc ; then
		dohtml doc/*.html
		dodoc doc/*.pod doc/*.txt
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
		insinto /usr/share/doc/${PF}/contrib
		doins contrib/*
	fi

	if use perl ; then
		perlinfo
		mytargets="site-perl-install"
		perl-module_src_install || die
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
