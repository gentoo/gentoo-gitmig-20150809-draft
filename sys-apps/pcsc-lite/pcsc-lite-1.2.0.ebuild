# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-lite/pcsc-lite-1.2.0.ebuild,v 1.2 2004/03/23 19:39:25 dragonheart Exp $

inherit eutils

DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="http://www.linuxnet.com/middle.html"
SRC_URI="https://alioth.debian.org/download.php/419/pcsc-lite-${PV}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="static"

RDEPEND="!static? ( virtual/glibc )
	!static? ( dev-libs/libusb )"

DEPEND="sys-devel/make
	sys-devel/libtool
	sys-apps/sed
	sys-devel/flex
	sys-apps/gawk
	dev-libs/libusb
	dev-util/pkgconfig
	sys-devel/gcc
	virtual/glibc
	dev-libs/libusb"

src_compile() {
	econf \
		--enable-usbdropdir=/usr/lib/readers/usb \
		--enable-muscledropdir=/usr/share/pcsc/services \
		`use_enable static` || die "./configure failed"
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog DRIVERS HELP INSTALL NEWS README SECURITY
	dodoc doc/*.pdf doc/README.DAEMON
	docinto sample
	dodoc src/utils/README src/utils/sample.*
	rm -rf ${D}/usr/doc

	exeinto /etc/init.d
	newexe ${FILESDIR}/pcscd-init pcscd
}
