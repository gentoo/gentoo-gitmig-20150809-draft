# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-desktop/gnome-python-desktop-2.26.0.ebuild,v 1.1 2009/05/10 21:52:07 eva Exp $

DESCRIPTION="Meta build which provides python interfacing modules for some GNOME desktop libraries"
HOMEPAGE="http://pygtk.org/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="~dev-python/bug-buddy-python-${PV}
	~dev-python/evolution-python-${PV}
	~dev-python/gnome-applets-python-${PV}
	~dev-python/gnome-desktop-python-${PV}
	~dev-python/gnome-keyring-python-${PV}
	~dev-python/gnome-media-python-${PV}
	~dev-python/gtksourceview-python-${PV}
	~dev-python/libgnomeprint-python-${PV}
	~dev-python/libgtop-python-${PV}
	~dev-python/librsvg-python-${PV}
	~dev-python/libwnck-python-${PV}
	~dev-python/metacity-python-${PV}
	~dev-python/nautilus-cd-burner-python-${PV}
	~dev-python/totem-python-${PV}"
