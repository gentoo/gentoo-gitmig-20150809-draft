# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kovpn/kovpn-0.3_pre2.ebuild,v 1.1 2006/04/26 16:23:48 tantive Exp $

inherit kde

DESCRIPTION="kvpnc - a simple OpenVPN GUI"
SRC_URI="http://home.bawue.de/~lighter/www.enlighter.de/files/${P}.tar.bz2"
HOMEPAGE="http://www.enlighter.de"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"
S=${WORKDIR}/${P}

DEPEND=">=net-misc/openvpn-2.0"
need-kde 3.4
