# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linpopup/linpopup-1.2.0.ebuild,v 1.6 2004/07/15 00:16:56 agriffis Exp $

MY_P=LinPopUp-${PV}
DESCRIPTION="LinPopUp, for sending/receiving WinPopup messages via Samba"
HOMEPAGE="http://www.littleigloo.org/"
SRC_URI="http://www.chez.com/littleigloo/files/${MY_P}.src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-fs/samba-2.2.7
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}/src

src_compile() {
	emake DESTDIR=/usr DOC_DIR=/usr/share/doc/${P} SHARE_DIR=/usr/share/${P} || die
}

src_install() {
	dobin LinPopUp
	doman ../LinPopUp.1
	dodoc ../AUTHORS ../BUGS ../COPYING ../ChangeLog ../INSTALL ../MANUAL ../NEWS ../README ../TODO ../THANKS
	insinto /usr/share/${P}
	doins ../extra/gtkrc
	insinto /usr/share/${P}/pixmaps
	doins ../pixmaps/little_igloo.xpm

	# Install messages.dat if not already present
	if [ ! -f /var/lib/linpopup/messages.dat ]
	then
		dodir /var/lib/linpopup
		touch messages.dat   # create (empty) file locally, then install
		insinto /var/lib/linpopup
		doins messages.dat
		fperms 0666 /var/lib/linpopup/messages.dat
	fi
}

pkg_postinst() {
	echo
	einfo "To be able to receive messages that are sent to you, you will need to"
	einfo "edit your /etc/samba/smb.conf file."
	einfo ""
	einfo "Add this line to the [global settings] section:"
	einfo ""
	einfo "   message command = /usr/bin/LinPopUp \"%f\" \"%m\" %s; rm %s"
	einfo ""
	einfo "PLEASE NOTE that \"%f\" is not the same thing as %f , '%f' or %f"
	einfo "and take care to enter \"%f\" \"%m\" %s exactly as shown above."
	einfo
	einfo "For more information, please refer to the documentation, found in"
	einfo "/usr/share/doc/${P}/INSTALL"
	echo
}
