# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.86-r1.ebuild,v 1.3 2009/12/14 18:12:06 ranger Exp $

EAPI="2"

inherit eutils

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="network-cron zlib"

DEPEND="virtual/libusb:0
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.82-fbsd.patch #275052
	sed -i '/^pkgconfigdir/s:datadir:datarootdir:' Makefile.in #287206
}

src_configure() {
	econf \
		--datarootdir=/usr/share \
		--datadir=/usr/share/misc \
		$(use_enable zlib)
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
