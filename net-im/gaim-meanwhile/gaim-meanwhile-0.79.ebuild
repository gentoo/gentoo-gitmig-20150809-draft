# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-meanwhile/gaim-meanwhile-0.79.ebuild,v 1.1 2004/07/19 01:05:26 rizzo Exp $

use debug && inherit debug

MY_PN="meanwhile-gaim"
DESCRIPTION="Gaim Meanwhile (Sametime protocol) Plugin"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/meanwhile/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="~net-libs/meanwhile-0.3
	>=net-im/gaim-${PV}"
IUSE="debug"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL README
}

