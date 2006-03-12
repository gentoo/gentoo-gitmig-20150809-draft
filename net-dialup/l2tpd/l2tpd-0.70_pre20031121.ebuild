# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/l2tpd/l2tpd-0.70_pre20031121.ebuild,v 1.5 2006/03/12 16:07:36 mrness Exp $

inherit eutils

MY_P="l2tpd_0.70-pre20031121"

DESCRIPTION="Layer 2 Tunnelling Protocol Daemon"
HOMEPAGE="http://l2tpd.snapgear.org/"
SRC_URI="mirror://debian/pool/main/l/l2tpd/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/l/l2tpd/${MY_P}-2.diff.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

S="${WORKDIR}/${P/_/-}.orig"

src_unpack() {
	unpack ${A}

	epatch "${MY_P}-2.diff"

	#Put CFLAGS from make.conf and disable builtin definition of log function
	sed -i.orig -e "s|-ggdb|${CFLAGS} -fno-builtin-log|" "${S}/Makefile" || die "failed to change CFLAGS in Makefile"
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

	newinitd "${FILESDIR}/l2tpd-init" l2tpd
}
