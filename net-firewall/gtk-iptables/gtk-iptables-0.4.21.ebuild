# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/gtk-iptables/gtk-iptables-0.4.21.ebuild,v 1.3 2004/07/14 23:45:29 agriffis Exp $

IUSE=""

DESCRIPTION="A GTK-1.2 front end for iptables"
HOMEPAGE="http://gtk-iptables.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="net-firewall/iptables"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die "make install failed"
	dodoc COPYING NEWS README
}
