# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.4.2.ebuild,v 1.6 2004/01/29 04:58:20 agriffis Exp $

inherit gnome2

DESCRIPTION="user interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2.1"

SLOT="2.2"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64"
IUSE="doc"

RDEPEND="=gnome-base/libgnomeprint-${PV}*
	>=gnome-base/libgnomecanvas-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.10 )"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

