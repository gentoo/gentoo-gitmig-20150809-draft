# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/krconlinux/krconlinux-0.2.ebuild,v 1.3 2005/07/14 12:20:14 swegener Exp $

inherit kde

DESCRIPTION="A tool for querying, managing and browsing game servers"
HOMEPAGE="http://krconlinux.nixgeneration.com/"
SRC_URI="http://krconlinux.nixgeneration.com/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

need-kde 3
