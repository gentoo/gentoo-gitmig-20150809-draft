# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/argus/argus-3.0.4.ebuild,v 1.3 2011/06/08 11:21:54 hwoarang Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="network Audit Record Generation and Utilization System"
HOMEPAGE="http://www.qosient.com/argus/"
SRC_URI="http://qosient.com/argus/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug tcpd"

#	sasl? ( >=dev-libs/cyrus-sasl-2.1.22 )
RDEPEND="net-libs/libpcap
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

DEPEND="${RDEPEND}
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.4.6"

src_prepare() {
	sed -e 's:/etc/argus.conf:/etc/argus/argus.conf:' \
		-i argus/argus.c \
		-i support/Config/argus.conf \
		-i man/man8/argus.8 \
		-i man/man5/argus.conf.5 || die

	sed -e 's:#\(ARGUS_SETUSER_ID=\).*:\1argus:' \
		-e 's:#\(ARGUS_SETGROUP_ID=\).*:\1argus:' \
		-e 's:\(#ARGUS_CHROOT_DIR=\).*:\1/var/lib/argus:' \
			-i support/Config/argus.conf || die
	epatch "${FILESDIR}"/${P}-disable-tcp-wrappers-automagic.patch
	eautoreconf
}

src_configure() {
	local myconf
	use debug && touch .debug # enable debugging
	econf $(use_with tcpd wrappers)
}

src_install () {
	doman man/man5/* man/man8/*
	dosbin bin/argus{,bug} || die

	dodoc ChangeLog CREDITS README || die

	insinto /etc/argus
	doins support/Config/argus.conf || die

	newinitd "${FILESDIR}/argus.initd" argus || die
	dodir /var/lib/argus
}

pkg_preinst() {
	enewgroup argus
	enewuser argus -1 -1 /var/lib/argus argus
}

pkg_postinst() {
	elog "Note, if you modify ARGUS_DAEMON value in argus.conf it's quite"
	elog "possible that init script will fail to work."
}
