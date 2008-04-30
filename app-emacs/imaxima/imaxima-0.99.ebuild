# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/imaxima/imaxima-0.99.ebuild,v 1.2 2008/04/30 11:02:37 bicatali Exp $

inherit elisp

MY_P="${PN}-imath-${PV}"
DESCRIPTION="Imaxima enables graphical output in Maxima sessions with emacs"
HOMEPAGE="http://members3.jcom.home.ne.jp/imaxima/Site/Welcome.html"
SRC_URI="http://members3.jcom.home.ne.jp/imaxima/Site/Download_and_Install_files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="virtual/latex-base
	virtual/ghostscript
	|| ( >=dev-tex/breqn-0.94 app-text/texlive )
	<sci-mathematics/maxima-5.15.0"

SITEFILE=50${PN}-gentoo.el
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --with-lispdir="${SITELISP}/${PN}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc ChangeLog NEWS README || die
	docinto imath-example
	dodoc imath-example/*.txt || die
}
