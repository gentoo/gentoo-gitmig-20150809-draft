# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.2.ebuild,v 1.1 2003/05/27 17:02:10 foser Exp $

inherit gnome2

DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2
	>=sys-devel/flex-2.5.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL NEWS  README*"

