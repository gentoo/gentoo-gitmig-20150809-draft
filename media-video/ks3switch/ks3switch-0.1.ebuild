# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ks3switch/ks3switch-0.1.ebuild,v 1.7 2004/07/06 12:32:52 carlo Exp $

inherit kde

DESCRIPTION="GUI for s3switch"
HOMEPAGE="http://code.bochatay.net/ks3switch"
SRC_URI="http://code.bochatay.net/ks3switch/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-apps/s3switch"
RDEPEND="sys-apps/s3switch"
need-kde 3