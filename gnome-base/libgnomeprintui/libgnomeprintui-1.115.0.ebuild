# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-1.115.0.ebuild,v 1.3 2002/07/19 13:14:50 stroke Exp $


inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="user interface libraries for gnome print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=gnome-base/libgnomeui-1.117.2
	>=gnome-base/libgnomeprint-1.115.0
	>=gnome-base/libgnomecanvas-1.117.0"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

