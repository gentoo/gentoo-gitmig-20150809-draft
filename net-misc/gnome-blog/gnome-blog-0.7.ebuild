# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-blog/gnome-blog-0.7.ebuild,v 1.3 2004/03/10 09:12:43 leonardop Exp $

inherit gnome2

DESCRIPTION="Post entries to your blog right from the Gnome panel"
HOMEPAGE="http://www.gnome.org/~seth/gnome-blog/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-python/gnome-python"

DEPEND="${RDEPEND}
	>=dev-python/pygtk-2
	>=gnome-base/gconf-2"

DOCS="AUTHORS ChangeLog COPYING README TODO"
