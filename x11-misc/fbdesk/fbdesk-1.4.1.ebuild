# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbdesk/fbdesk-1.4.1.ebuild,v 1.3 2008/04/24 08:50:34 omp Exp $

inherit eutils

DESCRIPTION="fluxbox-util application that creates and manage icons on your Fluxbox desktop"
HOMEPAGE="http://www.fluxbox.org/fbdesk/"
SRC_URI="http://www.fluxbox.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~ia64 ~amd64"
IUSE="debug png imlib2"

RDEPEND="png? ( media-libs/libpng )
		imlib2? ( media-libs/imlib2 )
		x11-libs/libXpm
		x11-libs/libXft"
DEPEND="${RDEPEND}
		x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
}

src_compile() {
	econf \
		$(use_enable imlib2) \
		$(use_enable debug) \
		$(use_enable png) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README
}
