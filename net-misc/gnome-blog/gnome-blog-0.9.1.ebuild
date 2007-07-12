# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-blog/gnome-blog-0.9.1.ebuild,v 1.2 2007/07/12 02:52:15 mr_bones_ Exp $

inherit gnome2

DESCRIPTION="Post entries to your blog right from the Gnome panel"
HOMEPAGE="http://www.gnome.org/~seth/gnome-blog/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=dev-python/pygtk-2.6
	dev-python/gnome-python"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack () {
	gnome2_src_unpack

	# Let this file be re-created so the path in the <oaf_server> element is
	# correct. See bug #93612.
	rm -f GNOME_BlogApplet.server.in
}
