# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/guarddog/guarddog-2.0.0.ebuild,v 1.5 2004/01/09 20:21:37 weeve Exp $

inherit kde-base

need-kde 3

DESCRIPTION="Firewall configuration utility for KDE 3"
SRC_URI="http://www.simonzone.com/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"
KEYWORDS="x86 sparc"
LICENSE="GPL-2"

newrdepend ">=net-firewall/iptables-1.2.5"
