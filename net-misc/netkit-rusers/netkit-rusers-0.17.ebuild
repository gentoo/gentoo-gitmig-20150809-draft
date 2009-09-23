# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rusers/netkit-rusers-0.17.ebuild,v 1.4 2009/09/23 19:40:07 patrick Exp $

DESCRIPTION="Netkit - rup rpc.rusersd rusers"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	./configure || die
	mv MCONFIG MCONFIG.ori
	sed -e "s:-O2::" -e "s:-Wpointer-arith::" MCONFIG.ori > MCONFIG
	# see bug #244867 for parallel make issues
	emake -j1 || die
}

src_install() {
	into /usr
	dobin rup/rup
	doman rup/rup.1
	dobin rpc.rusersd/rusersd
	doman rpc.rusersd/rpc.rusersd.8
	dobin rusers/rusers
	doman rusers/rusers.1
	dodoc README ChangeLog
}
