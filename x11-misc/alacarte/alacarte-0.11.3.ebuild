# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.11.3.ebuild,v 1.1 2007/03/27 17:25:04 dang Exp $

inherit gnome2 python

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://www.realistanew.com/projects/alacarte"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SLOT=0

RDEPEND=">=dev-lang/python-2.4
		 >=dev-python/pygtk-2.8
		 >=gnome-base/gnome-menus-2.15"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"
