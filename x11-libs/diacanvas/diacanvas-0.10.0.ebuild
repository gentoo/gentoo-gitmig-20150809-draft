# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/diacanvas/diacanvas-0.10.0.ebuild,v 1.1 2003/12/23 16:53:05 foser Exp $

inherit gnome2

MY_P=${PN}2-${PV}

DESCRIPTION="Gnome library to draw diagrams"
HOMEPAGE="http://diacanvas.sourceforge.net/"
SRC_URI="mirror://sourceforge/diacanvas/${MY_P}.tar.gz"

IUSE="python gnome doc"
SLOT="0"
KEYWORDS="~x86"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-libs/glib-2
	>=media-libs/libart_lgpl-2
	>=gnome-base/libgnomecanvas-2
	python? ( >=dev-lang/python-2.2
		>=dev-python/pygtk-2 )
	gnome? ( >=gnome-base/libgnomeprint-2.2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

S=${WORKDIR}/${MY_P}

G2CONF="${G2CONF} $(use_enable gnome gnome-print) $(use_enable python)"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

# 2 hacks needed for the python bindings to build
MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR="1"
