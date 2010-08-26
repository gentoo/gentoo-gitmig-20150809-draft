# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-timed/netkit-timed-0.17-r9.ebuild,v 1.1 2010/08/26 20:56:23 jer Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

IUSE=""
DESCRIPTION="Netkit - timed"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
LICENSE="BSD"
SLOT="0"

DEPEND=""

src_prepare() {
	epatch ${FILESDIR}/0.17-CFLAG-DEF-fix.patch
	epatch ${FILESDIR}/0.17-timed-opt-parsing.patch
	sed -i configure \
		-e '/^LDFLAGS=/d' \
		|| die "sed configure"
}

src_configure() {
	# Note this is not an autoconf configure script. econf fails
	append-flags -DCLK_TCK=CLOCKS_PER_SEC
	./configure --prefix=/usr --with-c-compiler=$(tc-getCC) || die "bad configure"
}

src_install() {
	dosbin timed/timed/timed
	doman  timed/timed/timed.8
	dosbin timed/timedc/timedc
	doman  timed/timedc/timedc.8
	dodoc  README ChangeLog BUGS

	newinitd ${FILESDIR}/timed.rc6 timed
}
