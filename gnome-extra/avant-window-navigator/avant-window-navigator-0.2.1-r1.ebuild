# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.2.1-r1.ebuild,v 1.1 2007/11/10 16:27:27 wltjr Exp $

inherit gnome2

DESCRIPTION="Fully customisable dock-like window navigator for GNOME."
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PV%.*}/${PV}/+download/${P}.tar"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2.8
	dev-python/gnome-python-desktop
	gnome-extra/gconf-editor
	x11-libs/libwnck"
RDEPEND="${DEPEND}"
