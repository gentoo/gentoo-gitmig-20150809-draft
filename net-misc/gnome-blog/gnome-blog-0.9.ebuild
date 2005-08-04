# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-blog/gnome-blog-0.9.ebuild,v 1.5 2005/08/04 08:05:42 blubb Exp $

inherit gnome2

DESCRIPTION="Post entries to your blog right from the Gnome panel"
HOMEPAGE="http://www.gnome.org/~seth/gnome-blog/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2
	>=gnome-base/gconf-2
	dev-python/gnome-python"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog README TODO"

src_unpack () {
	unpack ${A}
	cd ${S}

	# Let this file be re-created so the path in the <oaf_server> element is
	# correct. See bug #93612.
	rm GNOME_BlogApplet.server.in
}
