# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-2.0.4.ebuild,v 1.1 2002/09/06 03:24:40 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Essential Gnome Libraries"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/libxslt-1.0.20
	>=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	>=gnome-base/gnome-mime-data-2.0.1
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/gnome-vfs-2.0.4
	>=media-sound/esound-0.2.29
	>=media-libs/audiofile-0.2.3
	>=dev-libs/libxml2-2.4.24
	>=sys-apps/gawk-3.1.0
	>=sys-devel/perl-5.6.1-r3"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	doc? ( >=dev-util/gtk-doc-0.9 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING*  ChangeLog INSTALL NEWS README"
