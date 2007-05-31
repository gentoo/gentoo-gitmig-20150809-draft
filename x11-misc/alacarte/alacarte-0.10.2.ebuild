# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.10.2.ebuild,v 1.7 2007/05/31 15:39:22 jer Exp $

inherit eutils autotools gnome2 python

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://www.realistanew.com/projects/alacarte"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86"
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
