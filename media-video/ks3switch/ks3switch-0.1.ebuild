# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ks3switch/ks3switch-0.1.ebuild,v 1.6 2004/06/25 00:43:14 agriffis Exp $

inherit kde

need-kde 3

DESCRIPTION="GUI for s3switch"
SRC_URI="http://code.bochatay.net/ks3switch/${P}.tar.gz"
HOMEPAGE="http://code.bochatay.net/ks3switch"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "sys-apps/s3switch"
