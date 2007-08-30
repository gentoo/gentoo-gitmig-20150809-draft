# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/komparator/komparator-0.7.ebuild,v 1.1 2007/08/30 18:47:50 keytoaster Exp $

inherit eutils kde

DESCRIPTION="Komparator is a kde frontend for synchronising directories."
HOMEPAGE="http://komparator.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

need-kde 3.5
