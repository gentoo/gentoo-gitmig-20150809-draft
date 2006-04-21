# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.2-r1.ebuild,v 1.7 2006/04/21 01:12:20 vapier Exp $

inherit eutils autotools

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ia64 ~ppc ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	!net-misc/netkit-telnetd"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fbsd.patch

	eautoreconf
}

src_compile() {
	# FreeBSD doesn't seem to support PIE neither does hppa
	if use kernel_FreeBSD || use hppa; then
		export libc_cv_fpie="no"
	fi

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /etc/xinetd.d
	newins "${FILESDIR}"/telnetd.xinetd telnetd
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
