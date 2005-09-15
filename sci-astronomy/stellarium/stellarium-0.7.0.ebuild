# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.7.0.ebuild,v 1.1 2005/09/15 00:37:40 mr_bones_ Exp $

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://stellarium.free.fr/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	sys-devel/gettext"

src_compile() {
	# fails with --disable-nls.  Uptream notified at:
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1286227&group_id=48857&atid=454373
	econf \
		--disable-dependency-tracking \
		--enable-nls \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
