# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/guarddog/guarddog-2.6.0-r1.ebuild,v 1.1 2009/04/29 02:29:40 darkside Exp $

inherit kde

DESCRIPTION="Firewall configuration utility for KDE 3"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"
SRC_URI="http://www.simonzone.com/software/guarddog/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

RDEPEND=">=net-firewall/iptables-1.2.5
	sys-apps/gawk"
need-kde 3.5

pkg_preinst() {
	echo "Encoding=UTF-8" >> ${D}/usr/share/applnk/System/guarddog.desktop
	kde_pkg_preinst
}

src_install() {
	kde_src_install
	newinitd "${FILESDIR}"/guarddog.init guarddog || die
}
