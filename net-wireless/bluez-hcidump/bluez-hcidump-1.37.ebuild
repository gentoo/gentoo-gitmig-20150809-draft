# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hcidump/bluez-hcidump-1.37.ebuild,v 1.1 2007/07/07 09:09:50 betelgeuse Exp $

DESCRIPTION="Bluetooth HCI packet analyzer"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND=">=net-wireless/bluez-libs-3.12"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS || die
}
