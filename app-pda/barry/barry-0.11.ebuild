# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/barry/barry-0.11.ebuild,v 1.2 2008/07/27 11:36:31 loki_val Exp $

inherit base

DESCRIPTION="Barry is an Open Source Linux application that will allow
synchronization, backup, restore, program management, and charging for BlackBerry devices"
HOMEPAGE="http://www.netdirect.ca/software/packages/barry/"
SRC_URI="mirror://sourceforge/barry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libusb
	dev-libs/openssl"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README NEWS

	#  udev rules
	insinto /etc/udev/rules.d
	newins udev/10-blackberry.rules 10-blackberry.rules
}
