# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-bootpd/netkit-bootpd-2.4.ebuild,v 1.7 2008/11/11 02:10:40 flameeyes Exp $

inherit eutils

MY_P=${P/netkit-/}
DESCRIPTION="Netkit - bootp"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netboot/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netboot/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~hppa ~mips ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-misc.patch
}

src_compile() {
	emake linux || die "Error compilando"
}

src_install() {
	into /usr
	dosbin bootpd bootpef bootpgw bootptest
	dosym dosbin /usr/sbin/in.dosbin
	dosym bootpd /usr/sbin/in.bootpd
	dosym bootpef /usr/sbin/in.bootpef
	dosym bootpgw /usr/sbin/in.bootpgw
	dosym bootptest /usr/sbin/in.bootptest
	doman *.8 *.5
	dodoc README README-linux
#	newdoc rpc.bootparamd/README README.bootparamd
}
