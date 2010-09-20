# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nettop/nettop-0.2.3-r1.ebuild,v 1.4 2010/09/20 00:31:45 xmw Exp $

inherit eutils

DESCRIPTION="top like program for network activity"
SRC_URI="http://srparish.net/scripts/${P}.tar.gz"
HOMEPAGE="http://srparish.net/software/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~arm ppc sparc x86"
IUSE=""

DEPEND=">=sys-libs/slang-1.4
	net-libs/libpcap"

pkg_setup() {
	ewarn "This is known to break with distcc, see bug #169245 for details"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc411.patch
	epatch "${FILESDIR}"/${P}-offbyone.patch
}

src_compile() {
	local myconf
	myconf="--prefix=/usr"
	./configure ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dosbin nettop
	dodoc ChangeLog README THANKS
}
