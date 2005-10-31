# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/vamos/vamos-0.5.5.ebuild,v 1.1 2005/10/31 03:45:47 mr_bones_ Exp $

inherit eutils

DESCRIPTION="an automotive simulation framework"
HOMEPAGE="http://vamos.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/plib
	=dev-libs/libsigc++-1.2*
	media-libs/libpng
	virtual/x11
	virtual/opengl
	virtual/glu"

src_install() {
	make DESTDIR="${D}" install || die "make install"
	dobin caelum/.libs/caelum || die "caelum"
	newdoc caelum/README README.caelum
	dodoc AUTHORS ChangeLog NEWS README TODO
}
