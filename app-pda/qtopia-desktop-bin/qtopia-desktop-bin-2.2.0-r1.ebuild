# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/qtopia-desktop-bin/qtopia-desktop-bin-2.2.0-r1.ebuild,v 1.1 2008/09/06 05:17:14 vapier Exp $

inherit eutils fdo-mime rpm

REV="1"
QD="/opt/QtopiaDesktop"

DESCRIPTION="Qtopia Deskyop sync application (for use with Qtopia 2)"
HOMEPAGE="http://www.trolltech.com/developer/downloads/qtopia/desktopdownloads"
SRC_URI="ftp://ftp.trolltech.com/qtopia/desktop/RedHat9.0/qtopia-desktop-${PV}-${REV}-redhat9.i386.rpm"

LICENSE="trolltech_PUL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="sys-libs/glibc
	x11-libs/libX11
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	# keep before `into ${QD}` below
	make_wrapper qtopiadesktop "${QD}/bin/qtopiadesktop"
	make_desktop_entry \
		"qtopiadesktop" \
		"Qtopia Desktop" \
		"/opt/QtopiaDesktop/qtopiadesktop/pics/qtopia.png" \
		"Application;Office;ContactManagement;"

	dodir ${QD}
	# Too many subdirs and files for individual ebuild commands
	# Isn't there a better way?
	cp -a "${S}/${QD}"/qtopiadesktop "${D}${QD}" || die

	into ${QD}
	dolib.so "${S}/${QD}"/lib/lib* || die
	rm -f "${S}/${QD}"/lib/*.prl

	dobin "${S}/${QD}"/bin/* || die

	dohtml "${S}/${QD}"/README.html
	dodoc "${FILESDIR}"/usb0.conf
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog "See the usb0.conf file for a static network configuration for the"
	elog "Zaurus cradle interface (it works with an SL-5x00).  Note the old"
	elog "way of adding a config script to /etc/hotplug/usb also works, but"
	elog "depends on the desktop kernel version and module name, since the"
	elog "latest 2.6.16 module is cdc_ether for older models of the Zaurus"
	elog "(such as above) running OZ with kernel 2.4.x."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
