# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.10.0.ebuild,v 1.5 2006/10/03 23:08:48 agriffis Exp $

inherit gnome2 python

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://www.realistanew.com/projects/alacarte"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SLOT=0

RDEPEND=">=dev-lang/python-2.4
		 >=dev-python/pygtk-2.4
		 >=gnome-base/gnome-menus-2.15"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"
