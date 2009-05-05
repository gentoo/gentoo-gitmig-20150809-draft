# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmodbus/libmodbus-2.0.3.ebuild,v 1.1 2009/05/05 20:49:16 vapier Exp $

DESCRIPTION="Modbus library which supports RTU communication over a serial line or a TCP link"
HOMEPAGE="http://launchpad.net/libmodbus/"
SRC_URI="http://launchpad.net/libmodbus/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog MIGRATION NEWS README TODO
}
