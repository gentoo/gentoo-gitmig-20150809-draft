# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.73.ebuild,v 1.14 2009/01/04 16:50:23 vapier Exp $

inherit eutils autotools

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="network-cron zlib"

DEPEND="dev-libs/libusb"
		# zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp update-usbids.sh update-usbids.sh.orig
	epatch "${FILESDIR}"/${PN}-0.72-update-usbids.patch
	epatch "${FILESDIR}"/${P}-byteorder.patch

	# put usb.ids in same place as pci.ids (/usr/share/misc)
	sed -i \
		-e 's:/usr/share/usb.ids:/usr/share/misc/usb.ids:' \
		lsusb.8 || die "sed lsusb.8"
	sed -e '/^DEST=/s:=usb.ids:=/usr/share/misc/usb.ids:' \
		update-usbids.sh > update-usbids

	eautoreconf
}

src_compile() {
	# robbat2 - 2007/10/29
	# zlib disabled pending a revision of update-usbids from upstream.
	# $(use_enable zlib) \
	econf \
		--datadir=/usr/share/misc \
		--disable-zlib \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	newbin "${FILESDIR}"/usbmodules.sh usbmodules || die
	dosbin update-usbids || die "update-usbids failed"
	dodoc AUTHORS ChangeLog NEWS README

	use network-cron || return 0
	exeinto /etc/cron.monthly
	newexe "${FILESDIR}"/usbutils.cron update-usbids || die
}
