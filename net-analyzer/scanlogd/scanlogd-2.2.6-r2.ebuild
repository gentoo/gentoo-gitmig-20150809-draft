# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.6-r2.ebuild,v 1.3 2007/03/22 14:12:17 gustavoz Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Scanlogd - detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE="nids pcap"

DEPEND="nids? ( net-libs/libnids
	net-libs/libnet
	net-libs/libpcap )
	pcap? ( net-libs/libpcap )"
RDEPEND=${DEPEND}

pkg_setup() {
	enewgroup scanlogd
	enewuser scanlogd -1 -1 /dev/null scanlogd
	if use nids && use pcap ; then
		ewarn
		ewarn "As you set both nids and pcap useflag, we default to pcap"
		ewarn
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile.patch"
}

src_compile() {
	local target=linux
	use nids && target=libnids
	use pcap && target=libpcap

	einfo "Compiling against ${target}"

	emake CC="$(tc-getCC)" ${target} || die "emake failed"
}

src_install() {
	dosbin scanlogd
	doman scanlogd.8
	newinitd "${FILESDIR}"/scanlogd.rc scanlogd
}

pkg_postinst() {
	einfo "You can start the scanlogd monitoring program at boot by running"
	einfo "rc-update add scanlogd default"
}
