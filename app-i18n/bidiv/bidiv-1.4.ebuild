# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/bidiv/bidiv-1.4.ebuild,v 1.1 2003/10/04 08:27:43 coredumb Exp $

DESCRIPTION="A BiDirectional Text Viewer"
HOMEPAGE="http://www.ivrix.org.il"
SRC_URI="http://ftp.ivrix.org.il/pub/ivrix/src/cmdline/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND="dev-libs/fribidi"

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe bidiv
	dodoc README WHATSNEW
	doman bidiv.1
}
