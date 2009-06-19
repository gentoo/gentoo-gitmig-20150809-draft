# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/krecord/krecord-1.16.ebuild,v 1.4 2009/06/19 09:20:45 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

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

src_compile() {
	emake || die "emake failed"
}
