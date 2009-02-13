# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kguitar/kguitar-0.5-r1.ebuild,v 1.1 2009/02/13 20:34:18 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="An efficient and easy-to-use environment for a guitarist."
HOMEPAGE="http://kguitar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

# hard-dep on tse3, without it causes Settings->Configure KGuitar to crash. (eldad 15 April 2006)
DEPEND=">=media-libs/tse3-0.2.3"
RDEPEND="${DEPEND}"
need-kde 3.5

PATCHES=(
	"${FILESDIR}"/${P}+gcc-4.3.patch
	"${FILESDIR}"/kguitar-0.5-desktop-file.diff
	)

src_compile() {
	local myconf="--with-tse3"
	kde_src_compile
}
