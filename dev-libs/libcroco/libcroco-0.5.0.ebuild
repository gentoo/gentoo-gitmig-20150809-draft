# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcroco/libcroco-0.5.0.ebuild,v 1.5 2004/04/06 03:24:06 agriffis Exp $

inherit gnome2

DESCRIPTION="Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit"
HOMEPAGE="http://www.freespiders.org/projects/libcroco/"
LICENSE="LGPL-2 LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ia64"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2.4.23"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="ABOUT-NLS AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"
