# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guidedog/guidedog-0.9.0.ebuild,v 1.1 2002/08/18 00:38:36 bass Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="A network/routing configuration utility for KDE 3"
SRC_URI="http://www.simonzone.com/software/guidedog/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guidedog/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

newdepend ">=sys-apps/iptables-1.2.5"

