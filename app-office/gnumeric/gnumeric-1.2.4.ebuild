# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.2.4.ebuild,v 1.3 2004/01/08 00:18:49 foser Exp $

#provide Xmake and Xemake
inherit virtualx libtool gnome2 eutils

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64"

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
	>=gnome-extra/libgsf-1.8.2
	>=media-libs/libart_lgpl-2.3.11
	python? ( >=dev-lang/python-2
		>=dev-python/pygtk-2 )
	libgda? ( >=gnome-extra/libgda-1.0.1 )
	bonobo? ( >=gnome-base/libbonobo-2.2
		>=gnome-base/libbonoboui-2.2 )"
#	gnomedb? ( >=gnome-extra/libgnomedb-0.90.2 )

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27.2
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}
	gnome2_omf_fix

	cd ${S}
	# fix problems with libtool-0.28 generated stuff
	intltoolize --force

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	aclocal || die
	autoconf || die
	automake -a || die

}

src_compile() {

	econf \
		`use_with bonobo` \
		`use_with python` \
		`use_with libgda gda` \
		|| die
	# `use_with gnomedb gda`

	# the build process has to be able to connect to X
	Xemake || die

}

src_install() {

	gnome2_src_install

	dosym /usr/share/${PN}/${PV}/share/gnome/help/gnumeric /usr/share/gnome/help/gnumeric/

}

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"
