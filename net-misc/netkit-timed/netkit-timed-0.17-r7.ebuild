# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-timed/netkit-timed-0.17-r7.ebuild,v 1.10 2009/09/23 19:40:57 patrick Exp $

inherit eutils flag-o-matic

IUSE=""
DESCRIPTION="Netkit - timed"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="x86 sparc ppc mips ppc64 ~amd64"
LICENSE="BSD"
SLOT="0"

DEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/0.17-CFLAG-DEF-fix.patch
}

src_compile() {
	# Note this is no a autoconf configure script. econf fails
	append-flags -DCLK_TCK=CLOCKS_PER_SEC
	./configure --prefix=/usr || die "bad configure"
	emake || die "bad make"
}

src_install() {
	dosbin timed/timed/timed
	doman  timed/timed/timed.8
	dosbin timed/timedc/timedc
	doman  timed/timedc/timedc.8
	dodoc  README ChangeLog BUGS

	newinitd ${FILESDIR}/timed.rc6 timed
}
