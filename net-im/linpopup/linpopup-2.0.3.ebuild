# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linpopup/linpopup-2.0.3.ebuild,v 1.6 2004/07/20 20:30:39 jhuebel Exp $

inherit gnome2

DESCRIPTION="GTK2 port of the LinPopUp messaging client for Samba (including Samba 3)"
HOMEPAGE="http://linpopup2.sourceforge.net/"
SRC_URI="mirror://sourceforge/linpopup2/${P}.tar.bz2"
RESTRICT="nomirror"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gnome"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=net-fs/samba-2.2.8a"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL MANUAL NEWS README THANKS TODO"

src_install() {
	# Install icon and .desktop for menu entry
	if use gnome ; then
		insinto /usr/share/pixmaps
		newins ${S}/pixmaps/icon_256.xpm linpopup.xpm
		insinto /usr/share/applications
		doins ${FILESDIR}/linpopup.desktop
	fi

	gnome2_src_install
}

pkg_postinst() {
	echo
	einfo "To be able to receive messages that are sent to you, you will need to"
	einfo "edit your /etc/samba/smb.conf file."
	einfo
	einfo "Add this line to the [global settings] section:"
	einfo
	einfo "   message command = /usr/bin/linpopup \"%f\" \"%m\" %s; rm %s"
	einfo
	einfo "PLEASE NOTE that \"%f\" is not the same thing as %f , '%f' or %f"
	einfo "and take care to enter \"%f\" \"%m\" %s exactly as shown above."
	einfo
	einfo "For more information, please refer to the documentation, found in"
	einfo "/usr/share/doc/${P}/"
	echo
}
