# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r3.ebuild,v 1.7 2009/05/10 17:25:50 kingtaco Exp $

DESCRIPTION="Netkit - routed"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="mirror://debian/pool/main/n/netkit-routed/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 mips ppc sparc x86"
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
