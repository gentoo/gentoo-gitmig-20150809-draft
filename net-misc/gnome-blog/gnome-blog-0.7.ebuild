# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-blog/gnome-blog-0.7.ebuild,v 1.2 2003/12/10 19:57:51 leonardop Exp $

inherit gnome2

DESCRIPTION="Post entries to your blog right from the Gnome panel"
HOMEPAGE="http://www.gnome.org/~seth/gnome-blog/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-python/pygtk-2
	>=gnome-base/gconf-2"

DOCS="AUTHORS ChangeLog COPYING README TODO"
