# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-1.11.ebuild,v 1.1 2004/11/07 07:32:51 usata Exp $

DESCRIPTION="a nice LaTeX-IDE"

HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/x11
	>=x11-libs/qt-3.2*
	virtual/tetex
	app-text/psutils
	virtual/ghostscript
	media-libs/netpbm"

src_compile() {
	einfo "using QTDIR: '$QTDIR'."

	# from BUILD.sh:
	PATH=${QTDIR}/bin:${PATH}
	LD_LIBRARY_PATH=${QTDIR}/lib:${LD_LIBRARY_PATH}
	DYLD_LIBRARY_PATH=${QTDIR}/lib:${DYLD_LIBRARY_PATH}
	export QTDIR PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH

	qmake -unix texmaker.pro || die "qmake failed"

	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe texmaker || die "doexe failed"

	PIX=/usr/share/pixmaps/texmaker
	dodir ${PIX}
	insinto ${PIX}
	doins utilities/texmaker*.png || die "doins failed."

	dodoc utilities/{AUTHORS,COPYING} || die "dodoc failed"

	dohtml utilities/*.{html,gif,css,txt} utilities/doc*.png || die "dohtml failed"

	dosym /usr/share/doc/${PF}/html /usr/share/${PN} || die "dosym failed"
}

pkg_postinst() {
	einfo "A user manual with many screenshots is available at:"
	einfo "/usr/share/doc/${PF}/html/usermanual.html"
}
