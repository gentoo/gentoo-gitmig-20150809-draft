# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r2.ebuild,v 1.1 2003/05/24 03:21:28 agriffis Exp $

DESCRIPTION="Netkit - routed"
SRC_URI="http://ftp.debian.org/debian/pool/main/n/netkit-routed/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"

KEYWORDS="x86 sparc ppc mips alpha"
LICENSE="BSD"
SLOT="0"

src_compile() {  
	./configure || die
	make || die
}

src_install() {							   
	into /usr

	# ripquery
	dosbin ripquery/ripquery
	doman ripquery/ripquery.8

	# routed
	dosbin routed/routed
	dosym routed /usr/sbin/in.routed
	doman routed/routed.8
	dosym routed.8.gz /usr/share/man/man8/in.routed.8.gz

	# docs
	dodoc README ChangeLog
	newdoc routed/README README.routed

	# init scripts
	insinto /etc/conf.d
	newins "${FILESDIR}/routed.confd" routed
	exeinto /etc/init.d
	newexe "${FILESDIR}/routed.initd" routed
}
