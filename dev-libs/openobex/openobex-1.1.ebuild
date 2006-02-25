# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.1.ebuild,v 1.3 2006/02/25 11:09:08 ticho Exp $

inherit gnuconfig

IUSE="bluetooth debug irda syslog usb"

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openobex"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="virtual/libc
	usb? ( dev-libs/libusb )"

DEPEND="${DEPEND} ${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable irda) \
		$(use_enable bluetooth) \
		$(use_enable usb) \
		$(use_enable debug) \
		$(use_enable debug dump) \
		$(use_enable syslog) || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README AUTHORS NEWS ChangeLog
}
