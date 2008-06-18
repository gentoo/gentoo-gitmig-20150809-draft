# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.3.0.ebuild,v 1.3 2008/06/18 09:53:13 hanno Exp $

inherit flag-o-matic multilib perl-module

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://oss.oetiker.ch/rrdtool/"
SRC_URI="http://oss.oetiker.ch/rrdtool/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc perl python ruby rrdcgi tcl"

RDEPEND="tcl? ( dev-lang/tcl )
	>=sys-libs/zlib-1.2.1
	>=media-libs/freetype-2.1.5
	>=media-libs/libpng-1.2.5
	rrdcgi? ( >=dev-libs/cgilib-0.5 )
	ruby? ( !dev-ruby/ruby-rrd )
	x11-libs/cairo
	x11-libs/pango"

DEPEND="${RDEPEND}
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	sys-apps/gawk"
TCLVER=""

HTMLDOC_DIR="${PF}/html"

pkg_setup() {
	if ! built_with_use x11-libs/cairo svg; then
		eerror "This package requires x11-libs/cairo compiled with svg support."
		die "Please reemerge x11-libs/cairo with USE=\"svg\"."
	fi
	use perl && perl-module_pkg_setup
}

src_compile() {
	filter-mfpmath sse
	filter-flags -ffast-math

	export RRDDOCDIR=/usr/share/doc/${PF}

	econf $(use_enable rrdcgi) \
		$(use_enable ruby) \
		$(use_enable ruby ruby-site-install) \
		$(use_enable perl) \
		$(use_enable perl perl-site-install) \
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

	use tcl && dosym tclrrd${PV}.so /usr/lib/tclrrd.so
	use perl && fixlocalpod

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
