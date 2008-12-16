# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gbdfed/gbdfed-1.4.ebuild,v 1.2 2008/12/16 09:11:32 pva Exp $

DESCRIPTION="gbdfed Bitmap Font Editor"
HOMEPAGE="http://www.math.nmsu.edu/~mleisher/Software/gbdfed/"
SRC_URI="http://www.math.nmsu.edu/~mleisher/Software/gbdfed/${P}.tbz2"

LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6
		>=media-libs/freetype-2.0
		x11-libs/libX11
		x11-libs/pango"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed "s:-D.*_DISABLE_DEPRECATED::" -i Makefile.in #248562
}

src_install() {
	emake DESTDIR="${D}" install || die "install failure"
	dodoc README NEWS
}
