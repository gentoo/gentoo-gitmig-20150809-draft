# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-xosd/audacious-xosd-0.5.ebuild,v 1.4 2007/07/09 02:59:10 vapier Exp $

DESCRIPTION="Audacious plugin for overlaying text/glyphs in X-On-Screen-Display"
HOMEPAGE="http://www.netswarm.net/"
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/xosd-2.2.14
	 media-sound/audacious"

src_compile() {
	emake PREFIX=/usr || die "emake failed"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
