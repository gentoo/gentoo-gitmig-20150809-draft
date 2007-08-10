# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-talk/netkit-talk-0.17-r4.ebuild,v 1.21 2007/08/10 05:22:37 jer Exp $

inherit eutils

MY_P=netkit-ntalk-${PV}
S=${WORKDIR}/netkit-ntalk-${PV}

DESCRIPTION="Netkit - talkd"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PF}-gentoo.diff
	cd "${S}"
	use ipv6 && epatch "${FILESDIR}"/${P}-ipv6.diff
}

src_compile() {
	./configure || die
	sed -i -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG
	make || die
}

src_install() {
	insinto /etc/xinetd.d
	newins "${FILESDIR}"/talk.xinetd talk
	dobin talk/talk || die
	doman talk/talk.1
	dosbin talkd/talkd || die
	dosym talkd /usr/sbin/in.talkd
	doman talkd/talkd.8
	dosym talkd.8 /usr/share/man/man8/in.talkd.8
	dodoc README ChangeLog BUGS
}
