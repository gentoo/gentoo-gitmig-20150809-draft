# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsc/ipsc-0.4.3.2.ebuild,v 1.1 2006/06/14 09:06:13 chainsaw Exp $

DESCRIPTION="IP Subnet Calculator"
HOMEPAGE="http://packages.debian.org/unstable/net/ipsc.html"
SRC_URI="http://dev.gentoo.org/~chainsaw/${P}.tar.bz2 mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="virtual/libc"

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dodoc README ChangeLog TODO CONTRIBUTORS
	cd src
	dobin ipsc
	doman ipsc.1
}
