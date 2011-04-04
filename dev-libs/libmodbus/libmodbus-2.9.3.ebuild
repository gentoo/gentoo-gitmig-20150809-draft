# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmodbus/libmodbus-2.9.3.ebuild,v 1.1 2011/04/04 03:21:12 vapier Exp $

DESCRIPTION="Modbus library which supports RTU communication over a serial line or a TCP link"
HOMEPAGE="http://www.libmodbus.org/"
SRC_URI="http://github.com/downloads/stephane/libmodbus/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS MIGRATION NEWS README.rst
}
