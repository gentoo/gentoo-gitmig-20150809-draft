# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pio/pio-0.9.23.ebuild,v 1.1 2005/08/18 17:16:43 rizzo Exp $

inherit eutils gnome2 debug

MY_P="pioneers-${PV}"
DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://pio.sourceforge.net/"
SRC_URI="mirror://sourceforge/pio/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls debug X"

RDEPEND=">=dev-libs/glib-2.4
	>=gnome-base/libgnome-2.10
	X? ( >=x11-libs/gtk+-2.4
		>=app-text/scrollkeeper-0.3 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	export G2CONF="${G2CONF} `use_enable nls`"
	export G2CONF="${G2CONF} `use_enable debug`"

	if use X ; then
		gnome2_src_compile
	else
		einfo
		einfo "Only building console server"
		einfo

		econf ${G2CONF} || die "./configure failure"
		emake || die "emake failed"
	fi
}

src_install() {
	DOCS="AUTHORS ChangeLog README TODO NEWS"
	if use X ; then
		gnome2_src_install
	else
		make DESTDIR=${D} install
		dodoc ${DOCS}
	fi
}
