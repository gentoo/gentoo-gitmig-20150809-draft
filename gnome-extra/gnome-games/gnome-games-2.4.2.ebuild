# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.4.2.ebuild,v 1.3 2004/02/10 06:34:32 darkspecter Exp $

inherit gnome2

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

IUSE="guile"
SLOT="0"
KEYWORDS="x86 ppc ~alpha ~sparc ~hppa ~amd64 ~ia64"
LICENSE="GPL-2"

RDEPEND=">=app-text/scrollkeeper-0.3.8
	>=gnome-base/gconf-2.0
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	guile? ( dev-util/guile )"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	>=sys-devel/gettext-0.10.40
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO"

src_install() {
	gnome2_src_install

	# Documentation install for each of the games
	cd ${S}
	local GAMES=$( find . -type d -maxdepth 1)

	for game in ${GAMES}; do
		docinto ${game}
		dodoc ${game}/{AUTHORS,ChangeLog,TODO,NEWS,README,COPYING} > /dev/null
	done

	rm -rf ${D}/usr/share/doc/${P}/{libgames-support,po}

}
