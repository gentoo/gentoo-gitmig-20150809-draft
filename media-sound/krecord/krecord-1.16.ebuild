# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/krecord/krecord-1.16.ebuild,v 1.5 2009/06/19 09:58:07 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde toolchain-funcs

DESCRIPTION="A KDE sound recorder."
HOMEPAGE="http://bytesex.org/krecord.html"
SRC_URI="http://dl.bytesex.org/releases/krecord/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXmu
	x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-desktop_entry.patch"
	"${FILESDIR}/${P}-prestrip.patch" )

src_compile() {
	tc-export CC CXX
	emake || die "emake failed"
}
