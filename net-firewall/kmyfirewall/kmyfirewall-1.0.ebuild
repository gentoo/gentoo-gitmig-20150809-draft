# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-1.0.ebuild,v 1.1 2005/12/12 18:24:25 vanquirius Exp $

inherit kde eutils

DESCRIPTION="Graphical KDE iptables configuration tool"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmyfirewall/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-firewall/iptables"
need-kde 3

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-configure-arts.patch
	sed -i 's:gentoo_mode=false:gentoo_mode=true:' \
	"${S}"/kmyfirewall/kmyfirewallrc
}

pkg_postinst() {
	ewarn "Please note that rulesets created with kmyfirewall earlier"
	ewarn "than 1.0beta1 WILL NOT work."
}
