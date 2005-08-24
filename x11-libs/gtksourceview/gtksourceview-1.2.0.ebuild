# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtksourceview/gtksourceview-1.2.0.ebuild,v 1.10 2005/08/24 01:29:17 vapier Exp $

inherit gnome2

DESCRIPTION="GTK text widget with syntax highlighting and other features typical for a source editor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.5
	>=gnome-base/libgnomeprint-2.8"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.31
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

# Removes the gnome-vfs dep
G2CONF="${G2CONF} --disable-build-tests"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"
USE_DESTDIR="1"
