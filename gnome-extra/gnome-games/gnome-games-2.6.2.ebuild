# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.6.2.ebuild,v 1.2 2004/07/31 03:45:59 spider Exp $

inherit gnome2 eutils

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64"
IUSE="guile"

RDEPEND=">=x11-libs/gtk+-2.3
	>=gnome-base/gconf-1.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/librsvg-2
	guile? ( dev-util/guile )"
DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	>=sys-devel/gettext-0.10.40
	>=app-text/scrollkeeper-0.3.8
	${RDEPEND}"

DOCS="AUTHORS ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO"

src_install() {

	gnome2_src_install
	cd ${S}

	# Documentation install for each of the games
	for game in `find . -type d -maxdepth 1`
	do
		docinto ${game}
		dodoc ${game}/{AUTHORS,ChangeLog,TODO,NEWS,README,COPYING} > /dev/null
	done

	rm -rf ${D}/usr/share/doc/${P}/{libgames-support,po}

	# Avoid overwriting previous .scores files
	local basefile
	for scorefile in ${D}/var/lib/games/*.scores
	do
		basefile=$(basename $scorefile)
		if [ -s "${ROOT}/var/lib/games/${basefile}" ]
		then
		rm ${scorefile}
	fi
	done

}
