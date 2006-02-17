# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafd/trafd-3.0.1.ebuild,v 1.10 2006/02/17 16:26:25 jokey Exp $

inherit eutils

DESCRIPTION="The BPF Traffic Collector"
SRC_URI="ftp://ftp.riss-telecom.ru/pub/dev/trafd/${P}.tgz
	http://metalab.unc.edu/pub/Linux/system/network/management/tcpdump-richard-1.7.tar.gz
	mirror://gentoo/${P}-gentoo.tar.bz2"
HOMEPAGE="ftp://ftp.riss-telecom.ru/pub/dev/trafd/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""

# -lbpft -lpcap -lcurses -ltermcap -lfl
DEPEND="net-libs/libpcap
	sys-libs/ncurses
	sys-devel/flex"

PATCHDIR=${WORKDIR}/${P}-gentoo

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${PATCHDIR}/${PF}-gentoo.diff

	sed -i "44s:-O2$:${CFLAGS}:; 52s:^INCLUDE.*:& -I../../tcpdump-richard-1.7/libpcap-0.0/bpf/:" Makefile
}

src_install () {
	dodir /usr/bin /etc /usr/share/doc/trafd-3.0.1 /var/trafd
	make install DESTDIR=${D} || die
	exeinto /etc/init.d ; newexe ${PATCHDIR}/trafd.init trafd
	insinto /etc/conf.d ; newins ${PATCHDIR}/trafd.conf trafd
}

pkg_postinst() {
	ewarn "NOTE: if you want to run trafd on boot then execute"
	ewarn "rc-update add trafd default"
	ewarn "change interfaces in /etc/conf.d/trafd (default is eth0)"
}
