# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-1.115.0.ebuild,v 1.9 2003/02/13 12:13:24 vapier Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="user interface libraries for gnome print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=gnome-base/libgnomeui-1.117.2
	>=gnome-base/libgnomeprint-1.115.0
	>=gnome-base/libgnomecanvas-1.117.0"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

