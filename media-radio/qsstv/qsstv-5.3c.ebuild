# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qsstv/qsstv-5.3c.ebuild,v 1.4 2008/11/24 00:39:50 kingtaco Exp $

inherit kde

DESCRIPTION="Amateur radio SSTV software"
HOMEPAGE="http://users.telenet.be/on4qz/"
SRC_URI="http://users.telenet.be/on4qz/qsstv/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2"
IUSE=""

need-kde 3
