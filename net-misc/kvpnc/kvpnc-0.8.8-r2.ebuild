# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kvpnc/kvpnc-0.8.8-r2.ebuild,v 1.1 2007/04/27 11:35:03 voxus Exp $

inherit kde

DESCRIPTION="kvpnc - a KDE-VPN connection utility."
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"
HOMEPAGE="http://home.gna.org/kvpnc/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cisco smartcard"
SLOT="0"

DEPEND="dev-libs/libgcrypt"
RDEPEND="cisco? ( >=net-misc/vpnc-0.3.3-r1 <net-misc/vpnc-0.4 )
	smartcard? ( >=dev-libs/openct-0.6.11-r1 )"

need-kde 3.2
