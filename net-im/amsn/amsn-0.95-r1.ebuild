# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/amsn/amsn-0.95-r1.ebuild,v 1.2 2005/12/29 13:32:45 gothgirl Exp $

#S="${WORKDIR}/${P/./_}"
DESCRIPTION="Alvaro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://amsn.sourceforge.net"

IUSE="gnome kde imlib xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"


DEPEND=">=dev-lang/tcl-8.3
	>=dev-lang/tk-8.3
	"

RDEPEND="${DEPEND}
	dev-tcltk/tls
	xmms? ( media-plugins/xmms-infopipe )"

src_compile() {

	econf || die
	make || die
}

src_install() {
	dodir /usr/share/amsn/
	cp -pPR ${S}/* ${D}/usr/share/amsn/
	chmod -R 555 ${D}/usr/share/amsn

	# Remove all CVS extra stuff
	# not here in this version
	# find ${D} -type d -name CVS -exec rm -rf {} \;

	if use gnome
	then
		dodir /usr/share/applications
		cp ${D}/usr/share/amsn/amsn.desktop ${D}/usr/share/applications
		einfo "Installing GNOME Icons in /usr/share/pixmaps"
		dodir /usr/share/pixmaps
		cp -pPR ${S}/icons/32x32/* ${D}/usr/share/pixmaps/
	fi


	if use kde
	then
		dodir /usr/share/applnk/Internet
		cp ${D}/usr/share/amsn/amsn.desktop ${D}/usr/share/applnk/Internet/
		einfo "Installing KDE Icons in default theme"
		dodir /usr/share/pixmaps
		cp -pPR ${S}/icons/32x32/* ${D}/usr/share/pixmaps/
	fi

	rm -rf ${D}/usr/share/amsn/plugins/winflash
	rm -rf ${D}/usr/share/amsn/plugins/QuickTimeTcl3.1
	rm -rf ${D}/usr/share/amsn/plugins/applescript
	rm -rf ${D}/usr/share/amsn/plugins/tclCarbonNotification
	rm -rf ${D}/usr/share/amsn/plugins/tclAE2.0

	dodir /usr/bin/
	ln -s ../share/amsn/amsn ${D}/usr/bin/amsn

	cd ${D}/usr/share/amsn
	dodoc TODO README FAQ CREDITS HELP
	rm -f TODO

}

pkg_postinst() {

	ewarn "You might have to remove ~/.amsn prior to running as user if amsn hangs on start-up."

	if use xmms
	then
		einfo "For XMMS use in amsn, make sure the xmms-infopipe plugin is enabled."
	fi
}
