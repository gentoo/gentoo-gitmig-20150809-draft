# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.8.4-r2.ebuild,v 1.9 2010/07/20 16:32:43 jer Exp $

EAPI="2"

inherit gnome2 flag-o-matic python autotools

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="gnome perl python"
# bonobo guile libgda mono (experimental)

# lots of missing files, wait for next release
RESTRICT="test"

RDEPEND="sys-libs/zlib
	app-arch/bzip2
	>=dev-libs/glib-2.6
	>=gnome-extra/libgsf-1.14.6[gnome?]
	>=x11-libs/goffice-0.6.3:0.6
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1

	>=x11-libs/gtk+-2.16
	x11-libs/cairo[svg]
	>=gnome-base/libglade-2.3.6
	>=media-libs/libart_lgpl-2.3.11

	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=gnome-base/libbonobo-2.2
		>=gnome-base/libbonoboui-2.2 )
	perl? ( dev-lang/perl )
	python? (
		>=dev-lang/python-2
		>=dev-python/pygtk-2 )"
	# libgda? (
	#	>=gnome-extra/libgda-3.1.1
	#	>=gnome-extra/libgnomedb-3.0.1 )

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.18
	app-text/scrollkeeper"

DOCS="AUTHORS BEVERAGES BUGS ChangeLog HACKING MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-ssindex
		--disable-static
		--without-gda
		--without-guile
		--without-mono
		--with-zlib
		$(use_with perl)
		$(use_with python)
		$(use_with gnome)"

	# gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	replace-flags "-Os" "-O2"
}

src_prepare() {
	# Fix for CVE-2009-0318, bug #257012
	epatch "${FILESDIR}/${P}-CVE-2009-0318.patch"

	# Fix gtk+ 2.16 ABI changs wrt spinbuttons
	epatch "${FILESDIR}/${P}-gtk216-abi-spinbuttons.patch"

	# Fix gtk+-2.16 semantic changes, bug #278502
	epatch "${FILESDIR}/${P}-gtk216-im-block.patch"

	# Fix #275352 (the sed expression didn't work !)
	intltoolize --automake --copy --force || die "intltoolize failed"
	eautoreconf
}

src_install() {
	gnome2_src_install

	# Remove useless .la files
	find "${D}" -name "*.la" -delete

	# make gnumeric find its help
	dosym \
		/usr/share/gnome/help/gnumeric \
		/usr/share/${PN}/${PV}/doc
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
}
