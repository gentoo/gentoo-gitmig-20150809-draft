# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quark/quark-3.21.ebuild,v 1.7 2004/09/15 17:20:21 eradicator Exp $

IUSE=""

inherit gnome2

DESCRIPTION="Quark is the Anti-GUI Music Player with a cool Docklet!"
SRC_URI="http://quark.nerdnest.org/${P}.tar.gz"
HOMEPAGE="http://quark.nerdnest.org/"
SLOT="0"

KEYWORDS="x86 ~ppc ~alpha sparc amd64"

LICENSE="GPL-2"

DEPEND=">=media-libs/xine-lib-1_beta10
	>=x11-libs/gtk+-2.2.1
	>=gnome-base/gconf-2.2.0
	>=gnome-base/gnome-vfs-2.0.4-r2"

DOCS="AUTHORS README"

pkg_postinst () {
	einfo Quark is an anti-gui music player.
	einfo
	einfo Running the binary strange-quark will launch it in a
	einfo freedesktop.org dock ie: Gnome Notification Area
	einfo
}
