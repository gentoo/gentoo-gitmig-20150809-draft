# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hcidump/bluez-hcidump-1.40.ebuild,v 1.2 2009/11/21 15:21:16 armin76 Exp $

DESCRIPTION="Bluetooth HCI packet analyzer"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND=">=net-wireless/bluez-libs-3.14"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS || die
}
