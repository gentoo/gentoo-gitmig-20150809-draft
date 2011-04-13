# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmodbus/libmodbus-2.9.3.ebuild,v 1.2 2011/04/13 19:52:38 vapier Exp $

EAPI="2"

DESCRIPTION="Modbus library which supports RTU communication over a serial line or a TCP link"
HOMEPAGE="http://www.libmodbus.org/"
SRC_URI="http://github.com/downloads/stephane/libmodbus/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i '/CFLAGS/s:-Werror::' configure || die #363477
}

src_configure() {
	econf --disable-silent-rules
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS MIGRATION NEWS README.rst
}
