# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.2.ebuild,v 1.12 2004/06/24 23:18:45 agriffis Exp $

inherit gnome2

DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ia64 x86 ppc sparc alpha mips hppa amd64"

RDEPEND=">=dev-libs/glib-2
	>=sys-devel/flex-2.5.4"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS BUGS ChangeLog INSTALL NEWS README*"
