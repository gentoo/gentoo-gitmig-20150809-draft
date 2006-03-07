# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-ase-iiie-drv/pcsc-ase-iiie-drv-3.1.ebuild,v 1.2 2006/03/07 22:36:44 kingtaco Exp $

inherit eutils

MY_P="asedriveiiie"
DESCRIPTION="Driver for the Athena ASE IIIe SmartCard Reader/Writer"
HOMEPAGE="http://www.athena-scs.com/product.asp?pid=1"
SRC_URI="http://www.athena-scs.com/downloads/${MY_P}-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="usb"

DEPEND="sys-apps/pcsc-lite"
RDEPEND=""

src_compile() {
	cd ${WORKDIR}/${MY_P}serial-${PV}
	econf --with-pcsc-drivers-dir=/usr/$(get_libdir)/readers/usb/
	emake || die

	if use usb; then
		cd ${WORKDIR}/${MY_P}usb-${PV}
		econf --with-pcsc-drivers-dir=/usr/$(get_libdir)/readers/usb/
		emake || die
	fi
}

src_install() {
	cd ${WORKDIR}/${MY_P}serial-${PV}
	make install DESTDIR=${D}
	insinto /etc
	doins etc/reader.conf
	newdoc README README-serial

	if use usb; then
		cd ${WORKDIR}/${MY_P}usb-${PV}
		make install DESTDIR=${D}
		newdoc README README-usb

		einfo "If you use a USB-reader only, you should clean /etc/reader.conf"
		einfo "Otherwise the daemon would try to access the serial device."
		einfo
	fi

	einfo "Please (re-)start pcscd, so that it recognizes the new driver."
}
