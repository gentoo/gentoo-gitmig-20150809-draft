# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.82.ebuild,v 1.9 2009/11/28 16:24:07 armin76 Exp $

EAPI=1
DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="network-cron zlib"

DEPEND="virtual/libusb:0"
	# zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

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
	newsbin update-usbids.sh update-usbids || die "update-usbids failed"
	dodoc AUTHORS ChangeLog NEWS README

	use network-cron || return 0
	exeinto /etc/cron.monthly
	newexe "${FILESDIR}"/usbutils.cron update-usbids || die
}
