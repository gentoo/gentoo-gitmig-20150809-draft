# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hcidump/bluez-hcidump-1.41.ebuild,v 1.1 2008/02/01 21:52:02 betelgeuse Exp $

DESCRIPTION="Bluetooth HCI packet analyzer"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND=">=net-wireless/bluez-libs-3.14"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS || die
}
