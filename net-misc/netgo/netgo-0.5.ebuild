# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netgo/netgo-0.5.ebuild,v 1.2 2005/07/07 05:13:52 caleb Exp $

inherit eutils kde
need-qt 3

DESCRIPTION="A networking tool for changing network settings fast"
HOMEPAGE="http://netgo.hjolug.org"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

SRC_URI="http://netgo.hjolug.org/files/v${PV}/${P}.tar.gz"

DEPEND="=x11-libs/qt-3*
	sys-apps/net-tools"

src_install() {
	einstall INSTALL_ROOT=${D} || die "installation failed"
}
