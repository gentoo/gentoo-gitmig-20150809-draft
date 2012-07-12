# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-timed/netkit-timed-0.17-r8.ebuild,v 1.7 2012/07/12 15:56:15 axs Exp $

inherit eutils flag-o-matic

IUSE=""
DESCRIPTION="Netkit - timed"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="~amd64 ~mips ~ppc ppc64 sparc x86"
LICENSE="BSD GPL-2"
SLOT="0"

DEPEND=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/0.17-CFLAG-DEF-fix.patch
	epatch "${FILESDIR}"/0.17-timed-opt-parsing.patch
}

src_compile() {
	# Note this is not an autoconf configure script. econf fails
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

	newinitd "${FILESDIR}"/timed.rc6 timed
}
