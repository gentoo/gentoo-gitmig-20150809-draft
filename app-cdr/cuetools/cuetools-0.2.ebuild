# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cuetools/cuetools-0.2.ebuild,v 1.5 2005/01/01 12:11:49 eradicator Exp $

DESCRIPTION="Utilities to manipulate and convert .CUE- and .TOC-files"
HOMEPAGE="http://cuetools.sourceforge.net/"
SRC_URI="mirror://sourceforge/cuetools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake install prefix=${D}/usr || die "install failed"
	dodoc README ChangeLog
}
