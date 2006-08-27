# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.9.2.ebuild,v 1.1 2006/08/27 15:27:31 carlo Exp $

inherit kde

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"
SRC_URI="mirror://sourceforge/kile/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT=0
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="kde"

RDEPEND="dev-lang/perl
	virtual/tetex
	dev-tex/latex2html
	kde? ( || ( ( kde-base/kpdf
	              kde-base/kghostview
	              kde-base/kdvi
	              kde-base/kviewshell )
	            kde-base/kdegraphics ) )"

need-kde 3.2

LANGS="br ca cs cy da de el en_GB es et eu fi fr ga gl hi hu is it ja lt mt nb
nl nn pa pl pt pt_BR ro ru rw sk sr sr@Latn sv ta tr zh_CN"
for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_unpack() {
	kde_src_unpack

	if [[ -n ${LINGUAS} ]]; then
		MAKE_TRANSL=$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))
		einfo "Building translations for: ${MAKE_TRANSL}"
		sed -i -e "s:^SUBDIRS.*=.*:SUBDIRS = ${MAKE_TRANSL}:" ${S}/translations/Makefile.am || die "sed for locale failed"
		rm -f ${S}/configure
	fi
}
