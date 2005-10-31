# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.6.0.ebuild,v 1.3 2005/10/31 03:54:18 weeve Exp $

inherit eutils flag-o-matic gnome2

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

IUSE="gnome python static"
# bonobo gnomedb libgda

RDEPEND=">=dev-libs/glib-2.6
	>=gnome-extra/libgsf-1.13.2
	>=x11-libs/goffice-0.1.0
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1

	>=x11-libs/gtk+-2.6
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
	python? (
		>=dev-lang/python-2
		>=dev-python/pygtk-2 )"
	#libgda? ( >=gnome-extra/libgda-1.0.1 )
#	gnomedb? ( >=gnome-extra/libgnomedb-0.90.2 )

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper"

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	if use gnome && ! built_with_use gnome-extra/libgsf gnome; then
		einfo "libgsf needs to be compiled with gnome in USE"
		einfo "for this version of gnumeric to work. Rebuild"
		einfo "libgsf first like this :"
		einfo "USE=gnome emerge libgsf -vp"
		die "libgsf was built without gnome support..."
	fi
	#gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	replace-flags "-Os" "-O2"
}

src_unpack() {
	unpack "${A}"
	gnome2_omf_fix
	cd ${S}/doc/C
	gnome2_omf_fix Makefile.in
}

G2CONF="${G2CONF} $(use_with python) $(use_with gnome) $(use_enable static) --enable-ssindex"

src_install() {

	gnome2_src_install

	# make gnumeric find it's help
	dosym \
		/usr/share/gnome/help/gnumeric \
		/usr/share/${PN}/${PV}/doc

}
