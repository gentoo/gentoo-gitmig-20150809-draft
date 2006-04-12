# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pioneers/pioneers-0.9.61.ebuild,v 1.1 2006/04/12 17:35:39 mr_bones_ Exp $

inherit eutils gnome2

MY_P="pioneers-${PV}"
DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://pio.sourceforge.net/"
SRC_URI="mirror://sourceforge/pio/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.4
	>=gnome-base/libgnome-2.10
	>=x11-libs/gtk+-2.4
	>=app-text/scrollkeeper-0.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	export G2CONF="${G2CONF} $(use_enable nls)"
	gnome2_src_compile
}

src_install() {
	DOCS="AUTHORS ChangeLog README TODO NEWS"
	USE_DESTDIR=1
	gnome2_src_install scrollkeeper_localstate_dir="${D}"/var/lib/scrollkeeper/
}
