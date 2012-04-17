# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quark/quark-3.21.ebuild,v 1.16 2012/04/17 09:02:31 ssuominen Exp $

EAPI=4
GCONF_DEBUG=yes
inherit gnome2

DESCRIPTION="Quark is the Anti-GUI Music Player with a cool Docklet!"
HOMEPAGE="http://quark.nerdnest.org/"
SRC_URI="http://quark.nerdnest.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/xine-lib
	x11-libs/gtk+:2
	>=gnome-base/gconf-2
	gnome-base/gnome-vfs"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS README"

src_prepare() {
	sed -i \
		-e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		strange-quark/Makefile.{am,in} quark/Makefile.{am,in} || die #387823
}
