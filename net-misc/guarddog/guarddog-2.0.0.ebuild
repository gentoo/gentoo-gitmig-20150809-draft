# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guarddog/guarddog-2.0.0.ebuild,v 1.5 2003/03/11 22:19:09 mholzer Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="Firewall configuration utility for KDE 3"
SRC_URI="http://www.simonzone.com/software/guarddog/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"
KEYWORDS="~x86 ~sparc "
LICENSE="GPL-2"

newdepend ">=net-firewall/iptables-1.2.5"
