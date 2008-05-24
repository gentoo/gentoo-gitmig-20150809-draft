# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafd/trafd-3.0.1-r1.ebuild,v 1.3 2008/05/24 14:09:14 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The BPF Traffic Collector"
SRC_URI="ftp://ftp.riss-telecom.ru/pub/dev/trafd/${P}.tgz
	http://metalab.unc.edu/pub/Linux/system/network/management/tcpdump-richard-1.7.tar.gz"
HOMEPAGE="ftp://ftp.riss-telecom.ru/pub/dev/trafd/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""

# -lbpft -lpcap -lcurses -ltermcap -lfl
DEPEND="net-libs/libpcap
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
}

src_compile() {
	emake FLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	dodir /usr/bin /etc /usr/share/doc/trafd-3.0.1 /var/trafd
	emake install DESTDIR="${D}" || die "emake install failed"
	newinitd "${FILESDIR}/trafd.init" trafd
	newconfd "${FILESDIR}/trafd.conf" trafd
}

pkg_postinst() {
	ewarn "NOTE: if you want to run trafd on boot then execute"
	ewarn "rc-update add trafd default"
	ewarn "change interfaces in /etc/conf.d/trafd (default is eth0)"
}
