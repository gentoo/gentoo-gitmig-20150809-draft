# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/apollon/apollon-0.9.ebuild,v 1.2 2004/03/01 06:26:58 eradicator Exp $
inherit kde-base
need-kde 3
DESCRIPTION="A KDE-based giFT GUI"

HOMEPAGE="http://apollon.sourceforge.net"

SRC_URI="mirror://sourceforge/apollon/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"
newdepend ">=net-p2p/gift-0.11.4"
