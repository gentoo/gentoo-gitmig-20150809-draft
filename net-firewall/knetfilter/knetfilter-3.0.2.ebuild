# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/knetfilter/knetfilter-3.0.2.ebuild,v 1.4 2004/03/14 17:25:26 mr_bones_ Exp $

inherit kde

need-kde 3

LICENSE="GPL-2"
DESCRIPTION="Manage Iptables firewalls with this KDE app"
SRC_URI="http://expansa.sns.it:8080/knetfilter/${P}.tar.gz"
HOMEPAGE="http://expansa.sns.it:8080/knetfilter/"
KEYWORDS="x86 sparc "

newdepend ">=net-firewall/iptables-1.2.5"

src_unpack() {
	kde_src_unpack
	cd $S
	make distclean
	kde_sandbox_patch ${S}/src ${S}/src/scripts
}
