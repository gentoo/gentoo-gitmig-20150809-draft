# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomoradio/gnomoradio-0.13.ebuild,v 1.6 2005/12/26 14:51:59 lu_zero Exp $

IUSE="vorbis"

DESCRIPTION="Finds, fetches, shares, and plays freely licensed music."
HOMEPAGE="http://gnomoradio.org/"
SRC_URI="http://savannah.nongnu.org/download/gnomoradio/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND="=dev-cpp/gtkmm-2.2.11
	=dev-cpp/gconfmm-2.0.2
	=dev-cpp/libxmlpp-1.0*
	media-sound/esound
	vorbis? ( media-libs/libvorbis )"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
