# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15composer/g15composer-1.0.ebuild,v 1.1 2006/10/04 19:02:24 jokey Exp $

inherit eutils

DESCRIPTION="A library to render text and shapes into a buffer usable by the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="truetype"

RDEPEND="app-misc/g15daemon
	dev-libs/libg15render
	truetype? ( media-libs/freetype )"

DEPEND="${RDEPEND}
	dev-libs/libg15"

RDEPEND="${RDEPEND}
	sys-apps/coreutils"


src_compile() {
	econf \
		$(use_enable truetype ttf ) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}/${P}.rc" ${PN}

	dodoc AUTHORS README ChangeLog
}
