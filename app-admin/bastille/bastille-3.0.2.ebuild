# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/bastille/bastille-3.0.2.ebuild,v 1.3 2007/01/24 13:57:14 genone Exp $

inherit eutils

PATCHVER=0.1
MY_PN=${PN/b/B}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Bastille-Linux is a security hardening tool"
HOMEPAGE="http://bastille-linux.org/"
SRC_URI="mirror://sourceforge/${PN}-linux/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="X"

RDEPEND="net-firewall/iptables
	app-admin/logrotate
	dev-perl/Curses
	net-firewall/psad
	X? ( dev-perl/perl-tk )"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-gentoo-${PATCHVER}.patch

	cd ${S}
	cp ${FILESDIR}/bastille-${PV}-firewall.init ./bastille-firewall
	chmod a+x Install.sh bastille-ipchains bastille-netfilter
}

src_install() {

	cd ${S}
	DESTDIR=${D} ./Install.sh

	# Example configs
	cd ${S}
	insinto /usr/share/Bastille
	doins *.config

	exeinto /etc/init.d && newexe ${FILESDIR}/${P}-firewall.init ${PN}-firewall

	# Documentation
	cd ${S}
	dodoc *.txt BUGS Change* README*
}

pkg_postinst() {
	elog "Please be aware that when using the Server Lax, Server Moderate, or"
	elog "Server Paranoia configurations, you may need to use InteractiveBastille"
	elog "to set any advanced network information, such as masquerading and"
	elog "internal interfaces, if you plan to use them."
}
