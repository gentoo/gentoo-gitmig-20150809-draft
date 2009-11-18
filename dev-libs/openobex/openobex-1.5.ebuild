# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.5.ebuild,v 1.11 2009/11/18 18:38:10 armin76 Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
HOMEPAGE="http://sourceforge.net/projects/openobex/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 sparc x86"
IUSE="bluetooth debug irda syslog usb"

RDEPEND="bluetooth? ( || ( net-wireless/bluez net-wireless/bluez-libs ) )
	usb? ( virtual/libusb:0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-use-flags.patch
	eautoreconf
}

src_configure() {
	econf \
		--enable-apps \
		$(use_enable irda) \
		$(use_enable bluetooth) \
		$(use_enable usb) \
		$(use_enable debug) \
		$(use_enable debug dump) \
		$(use_enable syslog)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS NEWS ChangeLog
}
