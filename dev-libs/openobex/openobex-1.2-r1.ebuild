# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.2-r1.ebuild,v 1.1 2006/04/22 10:24:12 mrness Exp $

inherit autotools eutils gnuconfig

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
HOMEPAGE="http://sourceforge.net/projects/openobex"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
IUSE="bluetooth debug irda syslog usb"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DEPEND="usb? ( dev-libs/libusb )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	eautoreconf
	gnuconfig_update
}

src_compile() {
	econf --enable-apps \
		$(use_enable irda) \
		$(use_enable bluetooth) \
		$(use_enable usb) \
		$(use_enable debug) \
		$(use_enable debug dump) \
		$(use_enable syslog) || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc README AUTHORS NEWS ChangeLog
}
