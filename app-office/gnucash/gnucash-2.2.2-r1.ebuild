# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-2.2.2-r1.ebuild,v 1.2 2008/01/08 06:56:05 tove Exp $

inherit autotools eutils gnome2

DOC_VER="2.2.0"

DESCRIPTION="A personal finance manager."
HOMEPAGE="http://www.gnucash.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}-icon.svg.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

IUSE="ofx hbci chipcard debug quotes"

RDEPEND=">=dev-libs/glib-2.6.3
	|| ( ( >=dev-scheme/guile-1.8.3 >=dev-scheme/slib-3.1.4  )
	     (  <dev-scheme/guile-1.8.3  =dev-scheme/slib-3.1.1* ) )
	>=sys-libs/zlib-1.1.4
	>=dev-libs/popt-1.5
	>=x11-libs/gtk+-2.10
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libgnomeprint-2.10
	>=gnome-base/libgnomeprintui-2.10
	>=gnome-base/libglade-2.4
	>=gnome-extra/gtkhtml-3.14
	>=dev-libs/libxml2-2.5.10
	>=gnome-base/gconf-2
	>=app-text/scrollkeeper-0.3
	>=x11-libs/goffice-0.6
	ofx? ( >=dev-libs/libofx-0.7.0 )
	hbci? ( net-libs/aqbanking
		chipcard? ( sys-libs/libchipcard )
	)
	quotes? ( dev-perl/DateManip
		>=dev-perl/Finance-Quote-1.11
		dev-perl/HTML-TableExtract )
	dev-util/intltool
	media-libs/libart_lgpl
	x11-libs/pango"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/libtool"

PDEPEND=">=app-doc/gnucash-docs-${DOC_VER}"
ELTCONF="--patch-only"
DOC="AUTHORS ChangeLog* DOCUMENTERS HACKING NEWS TODO README* doc/README*"

pkg_setup() {
	local will_die=false
	local flags="deprecated regex"
	if ! built_with_use --missing true dev-scheme/guile ${flags} ; then
		eerror "dev-scheme/guile must be built with \"${flags}\" use flags"
		will_die=true
	fi
	if ! built_with_use gnome-extra/libgsf gnome ; then
		eerror "gnome-extra/libgsf must be built with gnome use flag"
		will_die=true
	fi
	if ! built_with_use x11-libs/goffice gnome ; then
		eerror "x11-libs/goffice must be built with gnome use flag"
		will_die=true
	fi

	if ${will_die} ; then
		die "Please rebuild the packages with the use flags above."
	fi
}

src_unpack() {
	unpack ${A}
	cp "${WORKDIR}"/gnucash-icon.svg "${S}"/src/pixmaps || die
	cd "${S}"
	epatch "${FILESDIR}"/${P}-icons.patch
	epatch "${FILESDIR}"/${P}-sx-fix-r16766.patch
	epatch "${FILESDIR}"/${P}-goffice.patch
	AT_M4DIR=macros eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ofx) \
		$(use_enable hbci) \
		--disable-doxygen \
		--enable-locale-specific-tax \
		--disable-error-on-warning \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_test() {
	GUILE_WARN_DEPRECATED=no \
	emake -j1 check \
	|| die "Make check failed. See above for details."
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn ""
	ewarn "If you are using Scheduled Transactions, the data file saved by"
	ewarn "GnuCash 2.2 is NOT backward-compatible with GnuCash 2.0."
	ewarn "Please make a safe backup of your 2.0 data before upgrading to 2.2"
	ewarn ""
}
