# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-lite/pcsc-lite-1.2.9_beta6.ebuild,v 1.1 2004/10/30 21:40:11 vapier Exp $

inherit eutils

NUM=753
MY_P="${PN}-${PV/_/-}"
DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="http://www.linuxnet.com/middle.html"
SRC_URI="https://alioth.debian.org/download.php/${NUM}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"

RDEPEND="!static? ( virtual/libc dev-libs/libusb )"
DEPEND="sys-devel/make
	sys-devel/libtool
	sys-apps/sed
	sys-devel/flex
	sys-apps/gawk
	dev-libs/libusb
	dev-util/pkgconfig
	sys-devel/gcc
	virtual/libc
	dev-libs/libusb
	>=sys-apps/portage-2.0.51"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--enable-usbdropdir=/usr/lib/readers/usb \
		--enable-muscledropdir=/usr/share/pcsc/services \
		$(use_enable static) \
		|| die "./configure failed"
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog DRIVERS HELP INSTALL NEWS README SECURITY
	dodoc doc/*.pdf doc/README.DAEMON
	docinto sample
	dodoc src/utils/README src/utils/sample.*
	rm -rf ${D}/usr/doc

	newinitd ${FILESDIR}/pcscd-init pcscd
}

pkg_postinst() {
	ewarn "You should run 'revdep-rebuild --soname libpcsclite.so.0'"
}
