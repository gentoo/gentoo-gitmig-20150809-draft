# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsvg/libsvg-0.1.4.ebuild,v 1.15 2006/09/10 00:15:27 the_paya Exp $

DESCRIPTION="A parser for SVG content in files or buffers"
HOMEPAGE="http://xsvg.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
