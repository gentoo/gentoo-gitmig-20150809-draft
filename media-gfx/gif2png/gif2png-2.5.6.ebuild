# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gif2png/gif2png-2.5.6.ebuild,v 1.1 2012/03/08 12:36:02 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Converts images from gif format to png format"
HOMEPAGE="http://catb.org/~esr/gif2png/"
SRC_URI="http://catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=media-libs/libpng-1.2:0
	sys-libs/zlib"
DEPEND="${RDEPEND}"

DOCS="AUTHORS NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.5.1-overflow.patch
}
