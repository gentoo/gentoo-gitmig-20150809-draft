# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r1.ebuild,v 1.20 2004/07/15 03:07:27 agriffis Exp $

DESCRIPTION="Netkit - routed"
SRC_URI="mirror://debian/pool/main/n/netkit-routed/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"

KEYWORDS="x86 sparc ppc mips"
IUSE=""
LICENSE="BSD"
SLOT="0"

src_compile() {
	./configure || die
	make || die
}

src_install() {
	into /usr
	dosbin ripquery/ripquery
	doman ripquery/ripquery.8
	dosbin routed/routed
	dosym routed /usr/sbin/in.routed
	doman routed/routed.8
	dosym routed.8.gz /usr/share/man/man8/in.routed.8.gz
	dodoc README ChangeLog
	newdoc routed/README README.routed
}
