# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-bootpd/netkit-bootpd-0.17-r2.ebuild,v 1.2 2005/11/29 03:18:37 vapier Exp $

inherit eutils

MY_PN=${PN/pd/paramd}
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Netkit - bootp"
SRC_URI="mirror://debian/pool/main/n/netkit-bootparamd/${MY_PN}_${PV}.orig.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"

KEYWORDS="~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""
LICENSE="BSD"
SLOT="0"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/0.17-jumpstart.patch || die "failed to apply patch"
}

src_compile() {
	# Note this is not an autoconf configure
	./configure || die
	emake || die
}

src_install() {
	into /usr
	dosbin rpc.bootparamd/bootparamd
	dosym bootparamd /usr/sbin/rpc.bootparamd
	doman rpc.bootparamd/bootparamd.8
	dosym bootparamd.8.gz /usr/share/man/man8/rpc.bootparamd.8.gz
	doman rpc.bootparamd/bootparams.5
	dodoc README ChangeLog
	newdoc rpc.bootparamd/README README.bootparamd
}
