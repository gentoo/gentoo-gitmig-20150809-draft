# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.12.0.ebuild,v 1.9 2005/08/19 03:22:51 metalgod Exp $

inherit gnome2

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 mips ppc ppc64 sparc x86"
IUSE="doc gnome static"

# FIXME : should add optional bz2 support
RDEPEND=">=dev-libs/libxml2-2.4.16
	>=dev-libs/glib-2.6
	sys-libs/zlib
	 gnome? ( >=gnome-base/libbonobo-2
	  	>=gnome-base/gnome-vfs-2.2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} $(use_with gnome) $(use_enable static)"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"
