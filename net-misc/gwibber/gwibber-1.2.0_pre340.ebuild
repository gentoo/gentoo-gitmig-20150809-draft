# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwibber/gwibber-1.2.0_pre340.ebuild,v 1.3 2009/10/07 14:56:19 volkmar Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Gwibber is an open source microblogging client for GNOME developed
with Python and GTK."
HOMEPAGE="https://launchpad.net/gwibber"
SRC_URI="http://dev.gentooexperimental.org/~zerox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/python-distutils-extra-1.92_pre67
	>=dev-python/dbus-python-0.82.4
	>=dev-python/pywebkitgtk-1.1.5
	>=dev-python/notify-python-0.1.1
	>=dev-python/imaging-1.1.6
	>=dev-python/simplejson-2.0.4
	>=dev-python/egenix-mx-base-2.0.5
	>=dev-python/feedparser-4.1
	>=dev-python/gconf-python-2.18.0
	>=dev-python/pyxdg-0.15
	>=dev-python/mako-0.2.4
	>=gnome-base/librsvg-2.22.2
	virtual/python"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "$FILESDIR/${PN}-prefix.patch" || die "Patching failed"
}
