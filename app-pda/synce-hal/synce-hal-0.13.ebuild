# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-hal/synce-hal-0.13.ebuild,v 1.2 2009/01/21 11:06:13 mescalinum Exp $

DESCRIPTION="SynCE - hal connection manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-apps/hal
		>=net-libs/gnet-2.0.0
		!app-pda/synce-dccm
		!app-pda/synce-vdccm
		!app-pda/synce-odccm
		=app-pda/synce-libsynce-${PV}*
		=app-pda/synce-librapi2-${PV}*
		=app-pda/synce-librra-${PV}*"
RDEPEND="${DEPEND}
		=app-pda/synce-sync-engine-${PV}*
		app-pda/synce-serial
		net-misc/dhcp"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_install() {
	make DESTDIR="${D}" install || die

	# fix collision with app-pda/synce-serial, bug 246675
	rm "${D}/usr/libexec/synce-serial-chat"

	dodoc AUTHORS README ChangeLog
}
