# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zniper/zniper-1.0.ebuild,v 1.1 2007/04/07 18:23:53 jokey Exp $

DESCRIPTION="Displays and kill active TCP connections seen by the selected interface."
HOMEPAGE="http://www.signedness.org/tools/"
SRC_URI="http://www.signedness.org/tools/zniper.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"

S=${WORKDIR}/"zniper"

src_compile() {
	emake -j1 linux_x86 || die "emake failed"
}

src_install() {
	dobin zniper
	dodoc README
	doman zniper.1
}
