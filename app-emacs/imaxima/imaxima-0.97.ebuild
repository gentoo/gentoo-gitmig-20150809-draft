# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/imaxima/imaxima-0.97.ebuild,v 1.2 2007/10/06 20:56:57 ulm Exp $

inherit eutils elisp

MY_P="${PN}-imath-${PV}"
DESCRIPTION="Imaxima enables graphical output in Maxima sessions with emacs"
HOMEPAGE="http://members3.jcom.home.ne.jp/imaxima/Site/Welcome.html"
SRC_URI="http://members3.jcom.home.ne.jp/imaxima/Site/Download%20and%20Install_files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND="virtual/tetex
	virtual/ghostscript
	|| ( >=dev-tex/breqn-0.94 app-text/texlive )
	>=sci-mathematics/maxima-5.10.0"

SITEFILE=50${PN}-gentoo.el
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog NEWS README
	docinto imath-example
	dodoc imath-example/*.txt
}
