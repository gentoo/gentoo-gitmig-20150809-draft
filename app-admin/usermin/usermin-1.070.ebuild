# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.070.ebuild,v 1.2 2004/04/23 00:23:15 eradicator Exp $

inherit eutils

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
IUSE="ssl"

DEPEND="dev-lang/perl
	sys-apps/lsof
	>=sys-apps/sed-4
	dev-perl/Authen-PAM
	ssl? ( dev-perl/Net-SSLeay )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix setup.sh for gentoo
	epatch ${FILESDIR}/${P}-gentoo.patch

	# Point to the correct mysql location
	sed -i "s:/usr/local/mysql:/usr:g" mysql/config

	# Bug #46273... missing config for gentoo
	cp quota/generic-linux-lib.pl quota/gentoo-linux-lib.p
}

src_install() {
	dodir /usr/libexec/usermin
	mv * ${D}/usr/libexec/usermin

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.usermin usermin

	insinto /etc/pam.d
	newins ${FILESDIR}/${PN}.pam ${PN}

	dosym ../usr/libexec/usermin /etc/usermin

	dodir /usr/sbin
	dosym ../libexec/usermin/usermin-init /usr/sbin/usermin
}

pkg_postinst() {
	einfo "Configure usermin by running \"/usr/libexec/usermin/setup.sh\"."
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

pkg_prerm() {
	test -f /var/lib/init.d/started/usermin && /etc/init.d/usermin stop
}
