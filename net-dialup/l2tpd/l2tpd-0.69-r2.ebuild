# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/l2tpd/l2tpd-0.69-r2.ebuild,v 1.1 2004/07/20 17:23:42 lanius Exp $

inherit eutils

DESCRIPTION="Layer 2 Tunnelling Protocol Daemon"
HOMEPAGE="http://www.l2tpd.org/"
MY_P="freeswan-l2tp-8jdl"
SRC_URI="http://www.jacco2.dds.nl/networking/tarballs/${MY_P}.tgz"

DEPEND="virtual/libc
	>=sys-apps/sed-4"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

S="${WORKDIR}/${MY_P}/${P}"

src_unpack() {
	unpack ${MY_P}.tgz || die
	cd ${MY_P} || die

	tar xzf ${P}.tar.gz || die
	cd ${S} || die

	epatch ../${PN}-pty.patch2.bz2
	epatch ../${PN}-pty-noecho.patch.bz2
	epatch ../${PN}-close.patch.bz2
	epatch ../${PN}-cfgpath.patch.bz2
	epatch ../${PN}-warnings.patch.bz2
	epatch ../${PN}-listenaddr.patch.bz2
	epatch ../${PN}-MSL2TP-hostname.patch.bz2

	epatch ${FILESDIR}/${P}-can-2004-0649.patch

	sed -i.orig -e "s|-g -O2|${CFLAGS}|" Makefile
		#-e "s|^#\(OSFLAGS+= -DUSE_KERNEL\)|\1|" \
		#^wants an #include <linux/l2tp>

	# gentoo file paths
	sed -i.orig \
		-e 's|\(#define DEFAULT_AUTH_FILE \).*|\1"/etc/l2tpd/l2tp-secrets"|' \
		-e 's|\(#define DEFAULT_CONFIG_FILE \).*|\1"/etc/l2tpd/l2tpd.conf"|' \
		-e 's|\(#define DEFAULT_PID_FILE \).*|\1"/var/run/l2tpd.pid"|' \
		file.h
}

src_compile() {
	emake || die
}

src_install() {
	dosbin l2tpd
	doman doc/*.[85]

	dodoc BUGS CHANGELOG LICENSE CREDITS README TODO \
		doc/rfc2661.txt doc/*.sample

	cd ..

	insinto /etc/l2tpd
	newins l2tpd-chapsecrets.sample l2tp-secrets
	doins l2tpd.conf

	insinto /etc/ppp
	newins l2tpd-options.l2tpd options-l2tp

	insinto /etc/ipsec
	doins l2tpd-L2TP-CERT-orgWIN2KXP.conf
	doins l2tpd-L2TP-CERT.conf
	doins l2tpd-L2TP-PSK-orgWIN2KXP.conf
	doins l2tpd-L2TP-PSK.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/l2tpd-init l2tpd
}
