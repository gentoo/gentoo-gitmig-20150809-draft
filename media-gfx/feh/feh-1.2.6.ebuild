# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.2.6.ebuild,v 1.9 2004/07/24 17:00:18 vapier Exp $

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND=">=media-libs/giblib-1.2.2
	>=media-libs/imlib2-1.0.0
	<media-libs/freetype-2"

src_install() {
	einstall docsdir=${D}/usr/share/doc/${PF} || die

	doman feh.1
	# gzip the docs
	gzip ${D}/usr/share/doc/${PF}/*

	dodoc AUTHORS ChangeLog README TODO
}
