# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomoradio/gnomoradio-0.15.1.ebuild,v 1.1 2004/11/14 18:57:11 eradicator Exp $

IUSE="oggvorbis"

DESCRIPTION="Finds, fetches, shares, and plays freely licensed music."
HOMEPAGE="http://gnomoradio.org/"
SRC_URI="http://savannah.nongnu.org/download/gnomoradio/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
# not linking for me on amd64 - eradicator
# ~ppc - needs gconfmm keyworded
KEYWORDS="-amd64 ~x86"

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libxmlpp-2.6
	>=dev-libs/libsigc++-2.0
	media-libs/libao
	oggvorbis? ( media-libs/libvorbis )"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
