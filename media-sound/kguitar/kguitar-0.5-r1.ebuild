# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kguitar/kguitar-0.5-r1.ebuild,v 1.2 2009/05/14 06:53:07 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="An efficient and easy-to-use environment for a guitarist."
HOMEPAGE="http://kguitar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/tse3"
DEPEND="${RDEPEND}"

need-kde 3.5

PATCHES=(
	"${FILESDIR}"/${P}+gcc-4.3.patch
	"${FILESDIR}"/kguitar-0.5-desktop-file.diff
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	local myconf="--with-tse3"
	kde_src_compile
}
