# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtksourceview/gtksourceview-0.7.0-r1.ebuild,v 1.3 2004/01/11 13:11:40 weeve Exp $

inherit gnome2

DESCRIPTION="GTK text widget with syntax highlighting and other features typical for a source editor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc hppa ~amd64"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.2
	>=dev-libs/libxml2-2.5
	>=gnome-base/libgnomeprint-2.2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

# Removes the gnome-vfs dep
G2CONF="${G2CONF} --disable-build-tests"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO"

src_unpack() {

	unpack ${A}

	# workaround patch for http://bugzilla.gnome.org/show_bug.cgi?id=120118
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.6.0-border_fix.patch

}
