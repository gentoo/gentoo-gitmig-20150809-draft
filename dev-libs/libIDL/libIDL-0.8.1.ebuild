# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.1.ebuild,v 1.5 2003/08/03 02:13:36 vapier Exp $

inherit gnome2 flag-o-matic

# FIXME : are these artifacts and can they be removed ?
# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
RESTRICT="nostrip"
append-flags -g

DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha amd64"

RDEPEND=">=dev-libs/glib-2
	>=sys-devel/flex-2.5.4"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf --enable-debug=yes || die
	emake || die
}

DOCS="AUTHORS BUGS ChangeLog INSTALL NEWS README*"
