# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camorama/camorama-0.19.ebuild,v 1.2 2008/01/23 17:44:04 drac Exp $

inherit gnome2

DESCRIPTION="a webcam application featuring various image filters."
HOMEPAGE="http://camorama.fixedgear.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

SCROLLKEEPER_UPDATE="0"
