# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lmule/lmule-1.2.0.1.ebuild,v 1.2 2003/05/07 13:00:25 liquidx Exp $

DESCRIPTION="GPL eDonkey clone that doesn't suck"
HOMEPAGE="http://lmule.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=x11-libs/wxGTK-2.4
	>=sys-libs/zlib-1.1.4"
S=${WORKDIR}/${P}
IUSE=""

# no parallel builds
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	einfo "Patching configure to remove GTK2 prompt.."
	cd ${S}; patch -p0 < ${FILESDIR}/${P}-disable_gtk2_prompt.patch
}

src_compile() {
	econf "--with-wx-config=/usr/bin/wx-config"|| die
	emake || die
}

src_install() {
	einstall || die
}
