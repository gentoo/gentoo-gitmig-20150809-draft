# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aqsis/aqsis-1.0.1.ebuild,v 1.1 2005/12/14 16:34:15 lu_zero Exp $

DESCRIPTION="Aqsis - a high-quality RenderMan compliant REYES render engine"
HOMEPAGE="http://www.aqsis.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="x11-libs/fltk
		media-libs/tiff
		media-libs/jpeg
		sys-libs/zlib
		"

src_compile()
{
	econf || die
	emake || die
}

src_install()
{
	einstall || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}

