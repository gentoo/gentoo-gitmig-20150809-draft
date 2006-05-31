# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/krconlinux/krconlinux-0.2.ebuild,v 1.6 2006/05/31 15:54:53 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="A tool for querying, managing and browsing game servers"
HOMEPAGE="http://krconlinux.nixgeneration.com/"
SRC_URI="http://krconlinux.nixgeneration.com/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3
