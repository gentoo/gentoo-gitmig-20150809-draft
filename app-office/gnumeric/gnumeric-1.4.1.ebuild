# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.4.1.ebuild,v 1.9 2005/03/28 19:11:00 hansmi Exp $

inherit virtualx gnome2 eutils flag-o-matic

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc sparc hppa ~amd64 ~alpha ~ia64 ~ppc64"

#IUSE="libgda gnomedb python bonobo"
IUSE="libgda python gnome"

RDEPEND=">=dev-libs/glib-2.4
	>=gnome-extra/libgsf-1.10
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.4

	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnomeprint-2.6
	>=gnome-base/libgnomeprintui-2.6
	>=media-libs/libart_lgpl-2.3.11

	gnome? ( >=x11-libs/gtk+-2.4
		>=gnome-base/libglade-2.4
		>=gnome-base/libgnomecanvas-2
		>=gnome-base/libgnomeprint-2.6
		>=gnome-base/libgnomeprintui-2.6
		>=media-libs/libart_lgpl-2.3.11
		>=gnome-base/gconf-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=gnome-base/libbonobo-2.2
		>=gnome-base/libbonoboui-2.2
		dev-util/pkgconfig )
	python? ( >=dev-lang/python-2
		>=dev-python/pygtk-2 )
	libgda? ( >=gnome-extra/libgda-1.0.1 )
	dev-util/pkgconfig" # see #67107
#	gnomedb? ( >=gnome-extra/libgnomedb-0.90.2 )

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-util/pkgconfig
	app-text/scrollkeeper"

pkg_setup() {

	if use gnome; then
		if ! pkg-config --exists libgsf-gnome-1; then
			einfo "libgsf needs to be compiled with gnome in USE"
			einfo "for this version of gnumeric to work. Rebuild"
			einfo "libgsf first like this :"
			einfo "USE=gnome emerge libgsf -vp"
			die "libgsf was built without gnome support..."
		fi
	fi
}

src_unpack() {

	unpack ${A}
	gnome2_omf_fix

	cd ${S}
	# simple code typo
	epatch ${FILESDIR}/${P}-bugfix.patch

}

src_compile() {

	# gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	replace-flags "-Os" "-O2"

	econf \
		`use_with python` \
		`use_with libgda gda` \
		`use_with gnome` \
		|| die
# building nogui is still too problematic
#		`use_with gtk` \
	# `use_with gnomedb gda`

	# the build process has to be able to connect to X
	Xemake || die

}

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"
