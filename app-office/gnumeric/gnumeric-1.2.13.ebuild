# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.2.13.ebuild,v 1.3 2004/10/25 17:40:45 foser Exp $

#provide Xmake and Xemake
inherit virtualx libtool gnome2 eutils flag-o-matic

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~hppa ~amd64 ~alpha ~ia64"

# evolution, perl, guile and gb support disabled currently (or to be removed)

# FIXME : should rethink gda/gnomedb USE stuff

#IUSE="libgda gnomedb python bonobo"
IUSE="libgda python bonobo"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.4.2
	>=gnome-base/libgnomeprintui-2.4.2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.4.12
	>=gnome-extra/libgsf-1.9
	>=media-libs/libart_lgpl-2.3.11
	python? ( >=dev-lang/python-2
		>=dev-python/pygtk-2 )
	libgda? ( >=gnome-extra/libgda-1.0.1 )
	bonobo? ( >=gnome-base/libbonobo-2.2
		>=gnome-base/libbonoboui-2.2 )"
#	gnomedb? ( >=gnome-extra/libgnomedb-0.90.2 )

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-util/pkgconfig"

pkg_setup() {

	if ! pkg-config --exists libgsf-gnome-1;
	then
		einfo "libgsf needs to be compiled with gnome in USE"
		einfo "for this version of gnumeric to work. Rebuild"
		einfo "libgsf first like this :"
		einfo "USE=gnome emerge libgsf -vp"
		die "libgsf was built without gnome support..."
	fi

}

src_unpack() {

	unpack ${A}
	gnome2_omf_fix

}

src_compile() {

	# gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	filter-flags "-Os"

	econf \
		`use_with bonobo` \
		`use_with python` \
		`use_with libgda gda` \
		|| die
	# `use_with gnomedb gda`

	# the build process has to be able to connect to X
	Xemake || die

}

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"
