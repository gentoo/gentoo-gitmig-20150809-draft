# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-fingerd/netkit-fingerd-0.17-r2.ebuild,v 1.24 2004/12/01 03:56:44 vapier Exp $

inherit eutils

MY_PN=${PN/netkit/bsd}
MY_PN=${MY_PN/rd/r}
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Netkit - fingerd"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="mirror://debian/pool/main/b/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
IUSE=""
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
SLOT="0"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure || die
	make || die
}

src_install() {
	into /usr
	dobin finger/finger || die
	dosbin fingerd/fingerd || die
	dosym fingerd /usr/sbin/in.fingerd
	doman finger/finger.1 fingerd/fingerd.8
	dosym fingerd.8.gz /usr/share/man/man8/in.fingerd.8.gz
	dodoc README ChangeLog BUGS

	insinto /etc/xinetd.d
	newins ${FILESDIR}/fingerd.xinetd fingerd
}
