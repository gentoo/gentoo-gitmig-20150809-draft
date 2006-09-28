# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/byzanz/byzanz-0.1.1.ebuild,v 1.2 2006/09/28 13:56:11 wolf31o2 Exp $

inherit eutils gnome2

DESCRIPTION="Screencasting program that saves casts as GIF files"
HOMEPAGE="http://people.freedesktop.org/~company/byzanz/"
SRC_URI="http://people.freedesktop.org/~company/byzanz/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/libXdamage-1.0
		>=dev-libs/glib-2.6
		>=x11-libs/gtk+-2.6
		>=gnome-base/gconf-2.10
		>=gnome-base/gnome-panel-2.10
		>=gnome-base/gnome-vfs-2.12
		>=gnome-base/libgnomeui-2.12"
DEPEND="dev-util/pkgconfig
		>=x11-proto/damageproto-1.0
		${RDEPEND}"
