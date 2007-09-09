# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-2.2.1.ebuild,v 1.1 2007/09/09 10:51:44 tove Exp $

inherit eutils gnome2

DOC_VER="2.2.0"

DESCRIPTION="A personal finance manager."
HOMEPAGE="http://www.gnucash.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-docs-${DOC_VER}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

IUSE="ofx hbci chipcard debug quotes nls"

RDEPEND=">=dev-libs/glib-2.6.3
	>=dev-scheme/guile-1.6
	=dev-scheme/slib-3.1.1*
	>=sys-libs/zlib-1.1.4
	>=dev-libs/popt-1.5
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libgnomeprint-2.10
	>=gnome-base/libgnomeprintui-2.10
	>=gnome-base/libglade-2.4
	|| (
		=gnome-extra/gtkhtml-3.12*
		=gnome-extra/gtkhtml-3.10*
	)
	>=dev-libs/libxml2-2.5.10
	>=gnome-base/gconf-2
	>=app-text/scrollkeeper-0.3
	>=x11-libs/goffice-0.1.0
	gnome-extra/yelp
	ofx? ( >=dev-libs/libofx-0.7.0 )
	hbci? ( net-libs/aqbanking
		chipcard? ( sys-libs/libchipcard )
	)
	quotes? ( dev-perl/DateManip
		>=dev-perl/Finance-Quote-1.11
		dev-perl/HTML-TableExtract )
	app-text/docbook-xsl-stylesheets
	=app-text/docbook-xml-dtd-4.1.2*
	nls? ( dev-util/intltool )
	media-libs/libart_lgpl
	x11-libs/pango"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/libtool"

ELTCONF="--patch-only"

pkg_setup() {
	local will_die=false
	if ! built_with_use gnome-extra/libgsf gnome ; then
		einfo "gnome-extra/libgsf must be built with gnome use flag"
		will_die=true
	fi
	if ! built_with_use x11-libs/goffice gnome ; then
		einfo "x11-libs/goffice must be built with gnome use flag"
		will_die=true
	fi

	if has_version =dev-scheme/guile-1.8* ; then
		local flags="deprecated regex"
		if ! built_with_use dev-scheme/guile ${flags}; then
			einfo "dev-scheme/guile must be built with \"${flags}\" use flags"
			will_die=true
		fi
	fi
	if ${will_die}; then
		die "Please rebuild the packages with the use flags above."
	fi
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ofx) \
		$(use_enable hbci) \
		--disable-doxygen \
		--enable-locale-specific-tax \
		|| die "econf failed"
	emake -j1 || die "emake failed"

	cd "${WORKDIR}/gnucash-docs-${DOC_VER}"
	econf || die "doc econf failed"
	emake -j1 || die "doc emake failed"
}

src_test() {
	GUILE_WARN_DEPRECATED=no \
	emake -j1 check \
	|| die "Make check failed. See above for details."
}

src_install() {
	gnome2_src_install || die "gnome2_src_install failed"
	dodoc AUTHORS ChangeLog* DOCUMENTERS HACKING NEWS TODO README* doc/README*

	cd "${WORKDIR}/${PN}-docs-${DOC_VER}"
	make DESTDIR="${D}" \
		scrollkeeper_localstate_dir="${D}/var/lib/scrollkeeper" \
		install || die "doc install failed"
	rm -rf "${D}/var/lib/scrollkeeper"
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn ""
	ewarn "If you are using Scheduled Transactions, the data file saved by"
	ewarn "GnuCash 2.2 is NOT backward-compatible with GnuCash 2.0."
	ewarn "Please make a safe backup of your 2.0 data before upgrading to 2.2"
	ewarn ""
}
