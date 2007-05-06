# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linpopup/linpopup-2.0.4-r1.ebuild,v 1.3 2007/05/06 11:43:30 genone Exp $

inherit gnome2 eutils

DESCRIPTION="GTK2 port of the LinPopUp messaging client for Samba (including Samba 3)"
HOMEPAGE="http://linpopup2.sourceforge.net/"
SRC_URI="mirror://sourceforge/linpopup2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="gnome"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=net-fs/samba-2.2.8a"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-libs/libXmu"

DOCS="AUTHORS BUGS ChangeLog INSTALL MANUAL NEWS README THANKS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-overflow.patch
}

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
	elog "To be able to receive messages that are sent to you, you will need to"
	elog "edit your /etc/samba/smb.conf file."
	elog
	elog "Add this line to the [global settings] section:"
	elog
	elog "   message command = /usr/bin/linpopup \"%f\" \"%m\" %s; rm %s"
	elog
	elog "PLEASE NOTE that \"%f\" is not the same thing as %f , '%f' or %f"
	elog "and take care to enter \"%f\" \"%m\" %s exactly as shown above."
	elog
	elog "For more information, please refer to the documentation, found in"
	elog "/usr/share/doc/${P}/"
	echo
}
