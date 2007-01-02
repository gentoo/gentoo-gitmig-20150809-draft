# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libg15render/libg15render-1.2.ebuild,v 1.1 2007/01/02 02:35:13 rbu Exp $

DESCRIPTION="Small library for display text and graphics on a Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

IUSE="truetype"

DEPEND="dev-libs/libg15
	truetype? ( media-libs/freetype )"

RDEPEND=${DEPEND}

src_compile() {
	econf \
		$(use_enable truetype ttf ) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
