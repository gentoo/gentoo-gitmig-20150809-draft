# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.4.0.ebuild,v 1.1 2003/09/11 23:48:29 spider Exp $

inherit gnome2

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"
LICENSE="GPL-2"

RDEPEND=">=app-text/scrollkeeper-0.3.8
	>=gnome-base/gconf-2.0
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	>=sys-devel/gettext-0.10.40
	${RDEPEND}"

# FIXME

DOCS="AUTHORS COPYING COPYING-DOCS ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO"

src_install() {
	gnome2_src_install

	for BLERHG in aisleriot blackjack glines gnect  gnibbles gnobots2 gnome-stones  gnometris gnomine gnotravex gnotski gtali iagno mahjongg same-gnome ; do
		docinto ${BLERHG}
		dodoc ${BLERHG}/AUTHORS ${BLERHG}/ChangeLog ${BLERHG}/TODO ${BLERHG}/NEWS ${BLERHG}/README ${BLERHG}/COPYING
	done
}
