# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/l2tpd/l2tpd-0.70_pre20031121.ebuild,v 1.2 2004/12/05 09:43:26 mrness Exp $

inherit eutils

DESCRIPTION="Layer 2 Tunnelling Protocol Daemon"
HOMEPAGE="http://www.l2tpd.org/"
MY_P="l2tpd_0.70-pre20031121"
S="${WORKDIR}/${P/_/-}.orig"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/l2tpd/${MY_P}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/l/l2tpd/${MY_P}-2.diff.gz"

DEPEND="virtual/libc
	>=sys-apps/sed-4"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${MY_P}.orig.tar.gz || die
	epatch ${DISTDIR}/${MY_P}-2.diff.gz || die

	cd ${S} || die

	#Put CFLAGS from make.conf and disable builtin definition of log function
	sed -i.orig -e "s|-ggdb|${CFLAGS} -fno-builtin-log|" Makefile || die
}

src_compile() {
	emake || die
}

src_install() {
	dosbin l2tpd
	doman doc/*.[85]
	doman *.[85]

	dodoc BUGS CHANGELOG LICENSE CREDITS README TODO \
		doc/rfc2661.txt doc/*.sample

	insinto /etc/l2tpd
	newins doc/l2tp-secrets.sample l2tp-secrets
	newins doc/l2tpd.conf.sample l2tpd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/l2tpd-init l2tpd
}
