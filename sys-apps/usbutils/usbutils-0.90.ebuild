# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.90.ebuild,v 1.7 2010/12/13 09:42:05 xmw Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://kernel/linux/utils/usb/usbutils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="network-cron zlib"

RDEPEND="virtual/libusb:0
	zlib? ( sys-libs/zlib )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.87-fbsd.patch #275052 #316671
	sed -i '/^pkgconfigdir/s:datadir:datarootdir:' Makefile.am #287206
	eautoreconf
}

src_configure() {
	econf \
		--datarootdir=/usr/share \
		--datadir=/usr/share/misc \
		$(use_enable zlib)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	mv "${D}"/usr/sbin/update-usbids{.sh,} || die
	newbin "${FILESDIR}"/usbmodules.sh usbmodules || die
	dodoc AUTHORS ChangeLog NEWS README

	use network-cron || return 0
	exeinto /etc/cron.monthly
	newexe "${FILESDIR}"/usbutils.cron update-usbids || die
}
