# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netgo/netgo-0.5.ebuild,v 1.3 2006/01/07 18:48:35 carlo Exp $

inherit eutils kde

DESCRIPTION="A networking tool for changing network settings fast"
HOMEPAGE="http://netgo.hjolug.org"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

SRC_URI="http://netgo.hjolug.org/files/v${PV}/${P}.tar.gz"

DEPEND="sys-apps/net-tools"
need-qt 3

src_install() {
	einstall INSTALL_ROOT=${D} || die "installation failed"
}
