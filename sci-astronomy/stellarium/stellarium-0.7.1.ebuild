# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.7.1.ebuild,v 1.5 2006/01/16 17:07:34 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://stellarium.free.fr/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

DEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/libpng
	media-libs/sdl-mixer
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	make_desktop_entry stellarium Stellarium
	dodoc AUTHORS ChangeLog README TODO
}
