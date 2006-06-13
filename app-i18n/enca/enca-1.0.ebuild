# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/enca/enca-1.0.ebuild,v 1.6 2006/06/13 19:20:04 corsair Exp $

DESCRIPTION="ENCA detects the character coding of a file and converts it if desired"
HOMEPAGE="http://trific.ath.cx/software/enca/"
SRC_URI="http://trific.ath.cx/Ftp/enca/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc64 x86"
IUSE=""

DEPEND=""

src_compile() {
	econf || die "Configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
