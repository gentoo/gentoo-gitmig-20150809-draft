# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/amsn/amsn-0.94.ebuild,v 1.1 2004/11/06 15:51:16 tester Exp $

S="${WORKDIR}/${P/./_}"
DESCRIPTION="Alvaro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${P/./_}.tar.gz"
HOMEPAGE="http://amsn.sourceforge.net"

IUSE="gnome kde imlib xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~hppa ~amd64"


DEPEND=">=dev-lang/tcl-8.3
	>=dev-lang/tk-8.3
	imlib? ( media-libs/imlib )"

RDEPEND="${DEPEND}
	dev-tcltk/tls
	media-gfx/imagemagick
	xmms? ( media-plugins/xmms-infopipe )"

src_compile() {

	if use imlib
	then
		einfo "Compiling the freedesktop notification plugin"
		cd ${S}/plugins/traydock
		econf || die
		make || die
	fi
}

src_install() {
	dodir /usr/share/amsn/
	cp -a ${S}/* ${D}/usr/share/amsn/

	# Remove all CVS extra stuff
	# not here in this version
	# find ${D} -type d -name CVS -exec rm -rf {} \;

	if use gnome
	then
		dodir /usr/share/applications
		cp ${D}/usr/share/amsn/amsn.desktop ${D}/usr/share/applications
		einfo "Installing GNOME Icons in /usr/share/pixmaps"
		dodir /usr/share/pixmaps
		cp -a ${S}/icons/32x32/* ${D}/usr/share/pixmaps/
	fi


	if use kde
	then
		dodir /usr/share/applnk/Internet
		cp ${D}/usr/share/amsn/amsn.desktop ${D}/usr/share/applnk/Internet/
		einfo "Installing KDE Icons in default theme"
		dodir ${KDEDIR}/share/icons/default.kde
		cp -a ${S}/icons/* ${D}/${KDEDIR}/share/icons/default.kde
	fi

	if use imlib
	then
		einfo "Installing the freedesktop notification plugin"
		dodir /usr/lib/amsn/plugins/traydock
		mv ${D}/usr/share/amsn/plugins/traydock/libtray.so ${D}/usr/lib/amsn/plugins/traydock
		ln -s /usr/lib/amsn/plugins/traydock ${D}/usr/share/amsn/plugins/traydock
	else
		rm -rf ${D}/usr/share/amsn/plugins/traydock
	fi

	rm -rf ${D}/usr/share/amsn/plugins/winflash
	rm -rf ${D}/usr/share/amsn/plugins/QuickTimeTcl3.1
	rm -rf ${D}/usr/share/amsn/plugins/applescript
	rm -rf ${D}/usr/share/amsn/plugins/tclCarbonNotification
	rm -rf ${D}/usr/share/amsn/plugins/tclAE2.0
	rm -rf ${D}/usr/share/amsn/utils/

	dodir /usr/bin/
	ln -s /usr/share/amsn/amsn ${D}/usr/bin/amsn

	cd ${D}/usr/share/amsn
	dodoc TODO README FAQ CREDITS HELP
	rm -f TODO
}
pkg_postinst() {
	if use xmms
	then
		einfo "For XMMS use in amsn, make sure the xmms-infopipe plugin is enabled."
	fi
}
