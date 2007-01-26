# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r3.ebuild,v 1.6 2007/01/26 08:46:39 vapier Exp $

DESCRIPTION="Netkit - routed"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="mirror://debian/pool/main/n/netkit-routed/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc ppc mips alpha"
IUSE=""

src_compile() {
	./configure || die
	make || die
}

src_install() {
	# ripquery
	dosbin ripquery/ripquery || die
	doman ripquery/ripquery.8

	# routed
	dosbin routed/routed || die
	dosym routed /usr/sbin/in.routed
	doman routed/routed.8
	dosym routed.8 /usr/share/man/man8/in.routed.8

	# docs
	dodoc README ChangeLog
	newdoc routed/README README.routed

	# init scripts
	newconfd "${FILESDIR}"/routed.confd routed
	newinitd "${FILESDIR}"/routed.initd routed
}
