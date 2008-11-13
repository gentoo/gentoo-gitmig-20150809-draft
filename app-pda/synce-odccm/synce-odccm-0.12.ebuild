# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-odccm/synce-odccm-0.12.ebuild,v 1.1 2008/11/13 00:16:53 mescalinum Exp $

DESCRIPTION="SynCE - odccm connection manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-apps/dbus
		sys-apps/hal
		>=net-libs/gnet-2.0.0
		!app-pda/synce-dccm
		!app-pda/synce-vdccm
		~app-pda/synce-libsynce-0.12
		~app-pda/synce-librapi2-0.12"

SRC_URI="mirror://sourceforge/synce/odccm-${PV}.tar.gz"
S="${WORKDIR}/odccm-${PV}"

src_install() {
	make DESTDIR="${D}" install || die

	insinto /etc/dbus-1/system.d/
	doins src/odccm.conf

	newinitd "${FILESDIR}"/init.odccm odccm

	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
