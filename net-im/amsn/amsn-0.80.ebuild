# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $id$

S="${WORKDIR}/msn"
DESCRIPTION="Alvaro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://amsn.sourceforge.net"

IUSE="gnome kde imlib"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"


DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
    imlib? ( media-libs/imlib )"

src_compile() {
	
	if [ -n "`use imlib`" ]
	then
		einfo "Compiling the freedesktop notification plugin"
		cd ${S}/plugins/traydock && econf || die
		make
	fi
}

src_install() {
	mkdir -p ${D}/usr/share/amsn/
	cp -a ${S}/* ${D}/usr/share/amsn/

	if [ -n "`use gnome`" ]
	then
		dodir /usr/share/applications
		cp ${FILESDIR}/amsn.desktop ${D}/usr/share/applications
		einfo "Installing GNOME Icons in /usr/share/pixmaps"
		mkdir -p ${D}/usr/share/pixmaps
		cp -a ${S}/icons/32x32/* ${D}/usr/share/pixmaps/
	fi
	

	if [ -n "`use kde`" ]
	then
		dodir ${D}/usr/share/applnk
		cp ${FILESDIR}/amsn.desktop ${D}/usr/share/applnk/
		einfo "Installing KDE Icons in default theme"
		mkdir -p ${D}/${KDEDIR}/share/icons/default.kde 
		cp -a ${S}/icons/* ${D}/${KDEDIR}/share/icons/default.kde
	fi

	if [ -n "`use imlib`" ]
	then
		einfo "Installing the freedesktop notification plugin"
		dodir /usr/lib/amsn/plugins/traydock
		mv ${D}/usr/share/amsn/plugins/traydock/libtray.so ${D}/usr/lib/amsn/plugins/traydock
		rm -rf ${D}/usr/share/amsn/plugins
		ln -s /usr/lib/amsn/plugins ${D}/usr/share/amsn/plugins
	else
		rm -rf ${D}/usr/share/amsn/plugins
	fi

	dodir /usr/bin/
	ln -s /usr/share/amsn/amsn ${D}/usr/bin/amsn

	dodoc TODO README FAQ

}
