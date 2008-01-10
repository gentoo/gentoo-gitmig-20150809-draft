# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.8.0.ebuild,v 1.7 2008/01/10 20:11:28 welp Exp $

inherit gnome2 flag-o-matic

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"

IUSE="gnome perl python"
# bonobo libgda

# lots of missing files, wait for next release
RESTRICT="test"

RDEPEND="sys-libs/zlib
	app-arch/bzip2
	>=dev-libs/glib-2.6
	>=gnome-extra/libgsf-1.14.6
	>=x11-libs/goffice-0.5.5
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1

	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2.3.6
	>=gnome-base/libgnomeprint-2.8.2
	>=gnome-base/libgnomeprintui-2.8.2
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
	G2CONF="${G2CONF}
		--enable-ssindex
		--enable-static
		$(use_with perl)
		$(use_with python)
		$(use_with gnome)"

	if use gnome && ! built_with_use gnome-extra/libgsf gnome; then
		eerror "libgsf needs to be compiled with gnome in USE"
		eerror "for this version of gnumeric to work. Rebuild"
		eerror "libgsf first like this :"
		eerror "USE=gnome emerge libgsf -vp"
		die "libgsf was built without gnome support..."
	fi

	# gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	replace-flags "-Os" "-O2"
}

src_unpack() {
	gnome2_src_unpack

	# Fix documentation
	epatch "${FILESDIR}/${P}-omf.patch"
}

src_install() {
	gnome2_src_install

	# make gnumeric find its help
	dosym \
		/usr/share/gnome/help/gnumeric \
		/usr/share/${PN}/${PV}/doc
}
