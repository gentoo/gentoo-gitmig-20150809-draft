# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.8.4.ebuild,v 1.1 2009/01/26 21:54:24 eva Exp $

inherit gnome2 flag-o-matic python

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="gnome perl python"
# bonobo guile libgda mono (experimental)

# lots of missing files, wait for next release
RESTRICT="test"

RDEPEND="sys-libs/zlib
	app-arch/bzip2
	>=dev-libs/glib-2.6
	>=gnome-extra/libgsf-1.14.6
	>=x11-libs/goffice-0.6.3
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1

	>=x11-libs/gtk+-2.10
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

DOCS="AUTHORS BEVERAGES BUGS ChangeLog HACKING MAINTAINERS NEWS README TODO"

pkg_setup() {
	local will_die=false

	G2CONF="${G2CONF}
		--enable-ssindex
		--enable-static
		--without-gda
		--without-guile
		--without-mono
		$(use_with perl)
		$(use_with python)
		$(use_with gnome)"

	if ! built_with_use x11-libs/cairo svg; then
		eerror "x11-libs/cairo needs to be built with svg support"
		eerror "please rebuild x11-libs/cairo with svg support"
		will_die=true
	fi

	if use gnome && ! built_with_use gnome-extra/libgsf gnome; then
		eerror "gnome-extra/libgsf needs to be compiled with gnome support"
		eerror "for this version of gnumeric to work. Rebuild"
		eerror "gnome-extra/libgsf first like this :"
		eerror "USE=gnome emerge libgsf -vp"
		will_die=true
	fi

	if ${will_die} ; then
		die "Please rebuild the packages with the use flags above."
	fi

	# gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	replace-flags "-Os" "-O2"
}

src_install() {
	gnome2_src_install

	# make gnumeric find its help
	dosym \
		/usr/share/gnome/help/gnumeric \
		/usr/share/${PN}/${PV}/doc
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
}
