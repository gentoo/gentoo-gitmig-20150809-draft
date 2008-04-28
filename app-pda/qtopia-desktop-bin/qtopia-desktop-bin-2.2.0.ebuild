# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/qtopia-desktop-bin/qtopia-desktop-bin-2.2.0.ebuild,v 1.7 2008/04/28 15:57:52 mr_bones_ Exp $

inherit eutils fdo-mime rpm multilib

REV="1"
QD="/opt/QtopiaDesktop"
S="${WORKDIR}"

DESCRIPTION="Qtopia Deskyop sync application for Zaurus PDA's"
SRC_URI="ftp://ftp.trolltech.com/qtopia/desktop/RedHat9.0/qtopia-desktop-${PV}-${REV}-redhat9.i386.rpm"
HOMEPAGE="http://www.trolltech.com/developer/downloads/qtopia/desktopdownloads"

LICENSE="trolltech_PUL-1.0"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

DEPEND=""
RDEPEND="virtual/libc
	x11-libs/libX11
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

RESTRICT="mirror strip"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	has_multilib_profile && ABI="x86"
}

pkg_unpack() {
	rpm_src_unpack
}

src_compile() { :; }

src_install() {
	dodir ${QD}
	# Too many subdirs and files for individual ebuild commands
	# Isn't there a better way?
	cp -a "${S}/${QD}"/qtopiadesktop "${D}${QD}"
	local libdir="lib32"
	if has_multilib_profile ; then
	    libdir=$(get_abi_LIBDIR x86)
	fi

	into ${QD}
	    dolib.so "${S}/${QD}"/lib/lib*
	    rm -f "${S}/${QD}"/lib/*.prl
	exeinto ${QD}/bin
	    doexe "${S}/${QD}"/bin/*
	docinto /usr/share/doc/${P}
	    dodoc "${S}/${QD}"/LICENSE.US
	    dodoc "${S}/${QD}"/README.html
	    dodoc "${FILESDIR}"/usb0.conf
	    rm -f "${S}/${QD}"/LICENSE*

	echo "PATH=${QD}/bin" > 37qtopia-desktop-bin
	echo "LDPATH=${QD}/${libdir}" >> 37qtopia-desktop-bin
	doenvd 37qtopia-desktop-bin

	make_desktop_entry \
	    /opt/QtopiaDesktop/bin/qtopiadesktop \
	    "Qtopia Desktop ${PV}" \
	    "/opt/QtopiaDesktop/qtopiadesktop/pics/qtopia.png" \
	    "Application;Office;ContactManagement;"
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog " Finished installing Qtopia Desktop ${PV}-${REV} into ${QD}"
	elog
	elog " To start Qtopia Desktop, use the new desktop menu, or run"
	elog " qtopiadesktop from a terminal prompt."
	elog
	elog "See the usb0.conf file for a static network configuration for the"
	elog "Zaurus cradle interface (it works with an SL-5x00).  Note the old"
	elog "way of adding a config script to /etc/hotplug/usb also works, but"
	elog "depends on the desktop kernel version and module name, since the"
	elog "latest 2.6.16 module is cdc_ether for older models of the Zaurus"
	elog "(such as above) running OZ with kernel 2.4.x."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
