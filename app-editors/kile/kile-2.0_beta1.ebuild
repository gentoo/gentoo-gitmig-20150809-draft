# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-2.0_beta1.ebuild,v 1.2 2007/08/21 22:45:12 philantrop Exp $

inherit kde

MY_P="${P/_beta/b}"
DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"
SRC_URI="mirror://sourceforge/kile/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT=0
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="kde"

RDEPEND="dev-lang/perl
	virtual/tetex
	dev-tex/latex2html
	kde? ( || ( (	kde-base/kpdf
					kde-base/kghostview
					kde-base/kdvi
					kde-base/kviewshell )
				kde-base/kdegraphics ) )"

need-kde 3.2

S="${WORKDIR}/${MY_P}"

src_install() {
	kde_src_install

	dodoc AUTHORS ChangeLog COPYING README README.cwl README.MacOSX TODO || die "installing docs failed"
}

pkg_postinst() {
	echo
	elog "${P} can use the following optional tools:"
	elog "- Adobe Reader (PDF Viewer)			- app-text/acroread"
	elog "- DVIPNG (PNG previews)			- app-text/dvipng"
	elog "- ImageMagick (PNG previews)			- media-gfx/imagemagick"
	elog "- zip (Archive)				- app-arch/zip"
	elog "- DBlatex (Docbook to LaTeX)			- cf. Gentoo bug 129368"
	elog "- Asymptote					- media-gfx/asymptote"
	elog "- Tex4ht (LaTeX to Web)			- dev-tex/tex4ht"
	elog "- Lilypond (Music Typesetting)		- media-sound/lilypond"
	elog "- Web-Browser (either of)			- kde-base/konqueror"
	elog "						- www-client/mozilla-firefox"
	elog "						- www-client/seamonkey"
	elog "For viewing BibTeX files:"
	elog "- Kbibtex					- app-text/kbibtex"
	elog "- KBib					- cf. Gentoo bug 147057"
	elog "- JabRef					- app-text/jabref"
	elog "- pybliographer				- app-office/pybliographer"
	echo
	elog "If you want to use either of these, please install them separately."
}
