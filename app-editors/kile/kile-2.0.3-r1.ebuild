# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-2.0.3-r1.ebuild,v 1.1 2009/04/15 18:19:59 tampakrap Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A LaTeX Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="kde"

RDEPEND="dev-lang/perl
	virtual/latex-base
	dev-tex/latex2html
	kde? (
		|| ( ( kde-base/kpdf:3.5
			kde-base/kghostview:3.5
			kde-base/kdvi:3.5
			kde-base/kviewshell:3.5 )
			kde-base/kdegraphics:3.5 )
		)"

need-kde 3.5

LANGS="ar bg br ca cs cy da de el en_GB es et eu fi fr ga gl hi hu is it ja lt ms mt nb
nds nl nn pa pl pt pt_BR ro ru rw sk sr sr@Latn sv ta th tr uk zh_CN"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

PATCHES=( "${FILESDIR}/kile-2.0.1-desktop-entry.diff" )

src_unpack() {
	kde_src_unpack

	if [[ -n ${LINGUAS} ]]; then
		MAKE_TRANSL=$(echo $(echo "${LINGUAS} ${LANGS}" | tr '[[:space:]]' '\n'  | sort | uniq -d))
		sed -i -e "s:^SUBDIRS.*=.*:SUBDIRS = ${MAKE_TRANSL}:" "${S}/translations/Makefile.am" || die "sed for locale failed"
		rm -f "${S}/configure"
	fi
}

src_install() {
	kde_src_install

	if has_version '>=kde-base/kdelibs-4.1'; then
		rm "${D}"/usr/share/apps/katepart/syntax/bibtex.xml
		rm "${D}"/usr/share/apps/katepart/syntax/latex.xml
	fi
}

pkg_postinst() {
	kde_pkg_postinst

	echo
	elog "${P} can use the following optional tools:"
	elog "- Adobe Reader (PDF Viewer)    - app-text/acroread"
	elog "- DVIPNG (PNG previews)        - app-text/dvipng"
	elog "- ImageMagick (PNG previews)   - media-gfx/imagemagick"
	elog "- zip (Archive)                - app-arch/zip"
	elog "- DBlatex (Docbook to LaTeX)   - cf. Gentoo bug 129368"
	elog "- Asymptote                    - media-gfx/asymptote"
	elog "- Tex4ht (LaTeX to Web)        - dev-tex/tex4ht"
	elog "- Lilypond (Music Typesetting) - media-sound/lilypond"
	elog "- Web-Browser (either of)      - kde-base/konqueror"
	elog "                               - www-client/mozilla-firefox"
	elog "                               - www-client/seamonkey"
	elog "For viewing BibTeX files:"
	elog "- Kbibtex                      - app-text/kbibtex"
	elog "- KBib                         - cf. Gentoo bug 147057"
	elog "- JabRef                       - app-text/jabref"
	elog "- pybliographer                - app-office/pybliographer"
	echo
	elog "If you want to use either of these, please install them separately."
}
