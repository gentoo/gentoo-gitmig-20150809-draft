# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ultimate/ultimate-3.0.0_rc2.ebuild,v 1.2 2005/02/17 02:25:54 swegener Exp $

inherit eutils fixheadtails

MY_P="Ultimate${PV/_/.}"

DESCRIPTION="An IRCd server based on DALnet's DreamForge IRCd."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.shadow-realm.org/"

KEYWORDS="~x86 ~sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="debug ssl"

RDEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-config.patch

	ht_fix_file configure
}

src_compile() {
	econf \
		--sysconfdir=/etc/ultimateircd \
		--localstatedir=/var/lib/ultimateircd \
		$(use_enable ssl openssl) \
		|| die "econf failed"
	emake || die "Make failed"
}

src_install() {
	dodir /etc/ultimateircd
	keepdir /var/log/ultimateircd /var/run/ultimateircd
	fowners nobody /var/log/ultimateircd /var/run/ultimateircd

	einstall \
		sysconfdir=${D}/etc/ultimateircd \
		localstatedir=${D}/var/lib/ultimateircd \
		networksubdir=${D}/etc/ultimateircd/networks \
		|| die "einstall failed"

	rm -f ${D}/usr/{{ircd,kill,rehash},bin/{ircdchk,ssl-{cert,search}.sh}}
	mv ${D}/usr/bin/ircd ${D}/usr/bin/ultimateircd
	mv ${D}/usr/bin/mkpasswd ${D}/usr/bin/ultimateircd-mkpasswd

	newinitd ${FILESDIR}/ultimateircd.rc-3.0.0 ultimateircd
	newconfd ${FILESDIR}/ultimateircd.conf ultimateircd
}
