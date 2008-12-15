# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gwibber/gwibber-0.7.ebuild,v 1.2 2008/12/15 04:54:21 neurogeek Exp $

inherit distutils

DESCRIPTION="Gwibber is an open source microblogging client for GNOME developed with Python and GTK."
HOMEPAGE="https://launchpad.net/gwibber"
SRC_URI="http://dev.gentooexperimental.org/~zerox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/dbus-python-0.82.4
	>=dev-python/pywebkitgtk-1.0.2
	>=dev-python/notify-python-0.1.1
	>=dev-python/simplejson-2.0.4
	>=dev-python/egenix-mx-base-2.0.5
	>=dev-python/feedparser-4.1
	>=dev-python/gnome-python-2.2.23
	>=dev-python/pyxdg-0.15
	>=gnome-base/librsvg-2.22.2"
DEPEND="virtual/python"

S=${WORKDIR}/${PN}
