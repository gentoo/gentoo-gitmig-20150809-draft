# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/knetfilter/knetfilter-3.5.0.ebuild,v 1.3 2006/05/30 01:55:20 weeve Exp $

inherit kde

DESCRIPTION="Manage Iptables firewalls with this KDE app"
HOMEPAGE="http://expansa.sns.it/knetfilter/"
SRC_URI="http://expansa.sns.it/knetfilter/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=net-firewall/iptables-1.2.5"
need-kde 3

src_unpack() {
	kde_src_unpack
	make distclean
	kde_sandbox_patch ${S}/src ${S}/src/scripts
}
