# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-1.2.1.ebuild,v 1.1 2005/12/07 14:06:36 nattfodd Exp $

inherit qt4 eutils

DESCRIPTION="a nice LaTeX-IDE"

HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~sparc ~ppc ~amd64"

IUSE=""

DEPEND="virtual/x11
	virtual/tetex
	app-text/psutils
	virtual/ghostscript
	media-libs/netpbm
	$(qt_min_version 4)"

src_compile() {
	cd ${S}
	qmake -unix texmaker.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin texmaker || die "doexe failed"

	insinto /usr/share/pixmaps/texmaker
	doins utilities/texmaker*.png || die "doins failed."

	dodoc utilities/{AUTHORS,COPYING} || die "dodoc failed"

	dohtml utilities/*.{html,gif,css,txt} utilities/doc*.png || die "dohtml failed"

	dosym /usr/share/doc/${PF}/html /usr/share/${PN} || die "dosym failed"

	make_desktop_entry texmaker Texmaker "/usr/share/pixmaps/texmaker/texmaker48x48.png" Office
}

pkg_postinst() {
	einfo "A user manual with many screenshots is available at:"
	einfo "/usr/share/doc/${PF}/html/usermanual.html"
}
