# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glitz/glitz-0.3.0.20050115.ebuild,v 1.1 2005/02/23 18:32:01 latexer Exp $

inherit eutils

MY_P=${P%.*}

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~x86 ~ppc64"
IUSE=""

DEPEND="virtual/opengl"
S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
