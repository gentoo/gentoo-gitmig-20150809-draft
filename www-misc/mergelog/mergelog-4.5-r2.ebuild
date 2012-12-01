# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/mergelog/mergelog-4.5-r2.ebuild,v 1.2 2012/12/01 21:27:15 ago Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils eutils

DESCRIPTION="A utility to merge apache logs in chronological order"
SRC_URI="mirror://sourceforge/mergelog/${P}.tar.gz"
HOMEPAGE="http://mergelog.sourceforge.net"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~x86"

DEPEND=""
RDEPEND=""

DOCS=( AUTHORS ChangeLog README)
PATCHES=(
	"${FILESDIR}"/${P}-splitlog.patch
	"${FILESDIR}"/${P}-asneeded.patch
)
