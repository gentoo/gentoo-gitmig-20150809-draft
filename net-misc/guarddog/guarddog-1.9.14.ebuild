# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/guarddog/guarddog-1.9.14.ebuild,v 1.2 2002/05/21 18:14:11 danarmak Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="A firewall configuration utility for KDE 2"
SRC_URI="http://www.simonzone.com/software/guarddog/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"

newdepend ">=sys-apps/iptables-1.2.5"

