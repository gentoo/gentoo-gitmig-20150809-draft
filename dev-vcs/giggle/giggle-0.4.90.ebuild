# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/giggle/giggle-0.4.90.ebuild,v 1.2 2010/03/17 16:42:52 sping Exp $

EAPI="1"

inherit gnome2

DESCRIPTION="GTK+ Frontend for GIT"
HOMEPAGE="http://live.gnome.org/giggle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-vcs/git-1.4.4.3
		 >=dev-libs/glib-2.18
		 >=x11-libs/gtk+-2.10
		 x11-libs/gtksourceview:2.0
		 gnome-extra/evolution-data-server
		 >=gnome-base/libglade-2.4"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/pkgconfig-0.15
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"
