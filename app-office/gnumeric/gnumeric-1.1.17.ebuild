# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.1.17.ebuild,v 1.1 2003/05/14 00:09:43 foser Exp $

#provide Xmake and Xemake
inherit virtualx libtool gnome2 eutils

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

# evolution, perl, guile and gb support disabled currently (or to be removed)

IUSE="libgda python bonobo"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libglade-2
	>=gnome-extra/gal-1.99
	>=dev-libs/libxml2-2.4.12
	>=gnome-extra/libgsf-1.8
	>=media-libs/libart_lgpl-2.3.11
	perl?   ( >=dev-lang/perl-5.6 )
	python? ( >=dev-lang/python-2.0 
		>=dev-python/pygtk-1.99.10 )
	libgda? ( >=gnome-extra/libgda-0.10 )
	bonobo? ( >=gnome-base/libbonobo-2
		>=gnome-base/libbonoboui-2
		>=gnome-base/bonobo-activation-1.0.2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix
}

src_compile() {
  	econf `use_with bonobo` `use_with python` `use_with libgda gda`

	#the build process have to be able to connect to X
	Xemake || Xmake || die
}

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"

USE_DESTDIR="1"

