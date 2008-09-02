# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/chesstask/chesstask-2.0.ebuild,v 1.8 2008/09/02 18:22:42 aballier Exp $

IUSE=""

S=${WORKDIR}/ChessTask
DESCRIPTION="An editor for chess problems. It will generate PostScript and HTML files."
HOMEPAGE="http://chesstask.sourceforge.net/"
SRC_URI="mirror://sourceforge/chesstask/ChessTask${PV/./_}src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"

DEPEND="=x11-libs/qt-3*
	app-arch/unzip
	|| ( ( dev-texlive/texlive-games dev-texlive/texlive-pstricks ) app-text/tetex app-text/ptex )"

src_compile() {
	sed -i -e "/ENGLISH/s/^#//" ChessTask.pro || die
	${QTDIR}/bin/qmake -o Makefile ChessTask.pro || die
	emake || die "compile failed"
}

src_install() {
	dobin ChessTask

	dodoc HISTORY LIESMICH README
}
