# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.0-r1.ebuild,v 1.4 2009/07/23 15:03:33 ssuominen Exp $

ARTS_REQUIRED="never"

inherit kde

P_I18N="${P}-i18n-20070422"

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/filelight/packages/${P}.tar.bz2
		http://www.methylblue.com/filelight/packages/${P_I18N}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="!kde-misc/filelight-i18n"
RDEPEND="x11-apps/xdpyinfo"

need-kde 3.5

LANGS="az bg br ca cs cy da de el en_GB es et fr ga gl is it ja ka lt nb nl pl pt pt_BR ro ru rw sr sr@Latn sv ta tr uk"
LANGS_DOC="da es et it pt ru sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

PATCHES=( "${FILESDIR}/filelight-1.0-desktop-entry-fix.diff" )

src_unpack() {
	kde_src_unpack
	rm "${S}"/configure "${WORKDIR}/${P_I18N}"/configure

	local sanitised_linguas=$(printf "${LINGUAS}" | tr '[[:space:]]' '\n' | sort | uniq)

	local MAKE_PO=$(printf "${sanitised_linguas} ${LANGS}" |  tr '[[:space:]]' '\n' | sort | uniq -d | tr '\n' ' ')
	einfo "Installing translations for: ${MAKE_PO}"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" "${WORKDIR}/${P_I18N}/po/Makefile.am" || die "sed for locale failed"

	local MAKE_DOC=$(echo "${sanitised_linguas} ${LANGS_DOC}" |  tr '[[:space:]]' '\n' | sort | uniq -d | tr '\n' ' ')
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = filelight ${MAKE_DOC}:" "${WORKDIR}/${P_I18N}/doc/Makefile.am" || die "sed for locale (docs) failed"
}

src_compile() {
	kde_src_compile
	KDE_S="${WORKDIR}/${P_I18N}"
	kde_src_compile
}

src_install() {
	kde_src_install
	KDE_S=""
	kde_src_install
}
