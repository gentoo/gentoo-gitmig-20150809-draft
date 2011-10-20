# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quark/quark-3.21.ebuild,v 1.15 2011/10/20 22:34:22 pacho Exp $

EAPI="4"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="Quark is the Anti-GUI Music Player with a cool Docklet!"
SRC_URI="http://quark.nerdnest.org/${P}.tar.gz"
HOMEPAGE="http://quark.nerdnest.org/"
SLOT="0"

KEYWORDS="alpha amd64 ppc sparc x86"

LICENSE="GPL-2"

IUSE=""
RDEPEND=">=media-libs/xine-lib-1_beta10
	>=x11-libs/gtk+-2.2.1:2
	>=gnome-base/gconf-2.2.0:2
	>=gnome-base/gnome-vfs-2.0.4-r2:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS README"

src_prepare() {
	# Drop DEPRECATED flags, bug #387823
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		strange-quark/Makefile.am strange-quark/Makefile.in \
		quark/Makefile.am quark/Makefile.in || die
}

pkg_postinst () {
	elog "Quark is an anti-gui music player."
	elog ""
	elog "Running the binary strange-quark will launch it in a"
	elog "freedesktop.org dock ie: Gnome Notification Area"
	elog ""
}
