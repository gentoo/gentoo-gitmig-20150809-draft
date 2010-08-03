# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/simple-scan/simple-scan-2.31.1.ebuild,v 1.2 2010/08/03 19:34:54 hwoarang Exp $

EAPI=2

inherit base

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="http://launchpad.net/simple-scan"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
	KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-gfx/sane-backends
	>=x11-libs/gtk+-2.18.0:2
	dev-libs/glib:2
	gnome-base/gconf:2
	app-text/gnome-doc-utils
	>=media-gfx/sane-backends-1.0.20
	sys-fs/udev[extras]
	x11-libs/cairo
	x11-misc/xdg-utils
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}"
