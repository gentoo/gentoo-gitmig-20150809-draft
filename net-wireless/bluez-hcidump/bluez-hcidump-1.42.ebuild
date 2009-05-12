# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hcidump/bluez-hcidump-1.42.ebuild,v 1.7 2009/05/12 10:13:21 loki_val Exp $

DESCRIPTION="Bluetooth HCI packet analyzer"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"

IUSE=""

DEPEND="|| ( net-wireless/bluez >=net-wireless/bluez-libs-3.14 )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS || die
}
