# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pslib/pslib-0.2.4.ebuild,v 1.2 2004/11/12 18:52:01 blubb Exp $

IUSE="png jpeg"

DESCRIPTION="pslib is a C-library to create PostScript files on the fly."
HOMEPAGE="http://pslib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pslib/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"
SLOT="0"

src_compile() {
	econf $(use_with png) $(use_with jpeg)  || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"
}
