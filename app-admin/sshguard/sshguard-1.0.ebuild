# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sshguard/sshguard-1.0.ebuild,v 1.3 2007/07/08 10:08:16 hawking Exp $

DESCRIPTION="protects hosts from brute force attacks against ssh"
HOMEPAGE="http://sshguard.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~x86-fbsd"
IUSE="ipfilter kernel_FreeBSD kernel_linux"

DEPEND="kernel_linux? ( net-firewall/iptables )
	kernel_FreeBSD? ( !ipfilter? ( sys-freebsd/freebsd-pf ) )"
RDEPEND="${DEPEND}
	virtual/logger"

src_compile() {
	local myconf
	if use kernel_linux; then
		myconf="--with-firewall=iptables"
	elif use kernel_FreeBSD; then
		use ipfilter && myconf="--with-firewall=ipfw" \
			|| myconf="--with-firewall=pf"
	fi

	econf ${myconf}
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README Changes || die "dodoc failed"
	dodoc examples/* || die "dodoc failed"
}
