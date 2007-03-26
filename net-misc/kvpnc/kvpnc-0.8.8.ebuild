# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kvpnc/kvpnc-0.8.8.ebuild,v 1.3 2007/03/26 07:55:13 voxus Exp $

inherit kde

DESCRIPTION="kvpnc - a KDE-VPN connection utility."
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"
HOMEPAGE="http://home.gna.org/kvpnc/"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""
SLOT="0"

DEPEND="dev-libs/libgcrypt"
RDEPEND=">=net-misc/vpnc-0.2"
need-kde 3.2
