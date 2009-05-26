# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.9.5.ebuild,v 1.1 2009/05/26 09:32:58 scarabeus Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
P_DOC="${PN}-doc-${PV/_*/}"
S_DOC="${WORKDIR}/${P_DOC}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/${P_DOC}.tar.bz2 )"
SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="nfs doc"

DEPEND=">=dev-db/sqlite-3.5.9:3
	>=media-libs/libgphoto2-2.2
	>=media-libs/libkipi-0.1.5
	>=media-libs/tiff-3.8.2
	>=media-libs/lcms-1.14
	>=media-libs/libpng-1.2
	>=media-libs/jasper-1.7
	>=media-libs/libkexiv2-0.1.9
	>=media-libs/libkdcraw-0.1.9
	media-libs/jasper
	!media-plugins/digikamimageplugins"

RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:0
	|| ( ( kde-base/kgamma:3.5 kde-base/kamera:3.5 )
		kde-base/kdegraphics:3.5 )"

need-kde 3.5

LANGS="ar bg br ca cs cy da de el en_GB es et fa fi fr gl he hu is it ja ka lt
mk ms mt nb nds nl nn pa pl pt pt_BR ro ru rw sk sl sr sr@Latn sv ta th tr uk vi
zh_CN zh_TW"

LANGS_DOC_DIGIKAM="da de es et it nl pt ru sv"

LANGS_DOC_SHOWFOTO="da de es et it nl sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_unpack(){
	kde_src_unpack

	rm -f "${S}/configure" "${S_DOC}/configure"

	local MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | tr ' ' '\n' | sort | uniq -d | tr '\n' ' ')
	elog "Preparing to build translations for: en ${MAKE_PO}"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" "${S}/po/Makefile.am" || die "sed for locale failed"

	if use doc; then
		cd "${S_DOC}/doc"
		MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC_DIGIKAM}" | tr ' ' '\n' | sort | uniq -d | tr '\n' ' ')
		elog "Preparing to build digiKam documentation for: en ${MAKE_DOC}"
		for X in ${MAKE_DOC}; do
			DIRS+="$(ls -d ${X}_digikam) "
		done
		MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC_SHOWFOTO}" | tr ' ' '\n' | sort | uniq -d | tr '\n' ' ')
		elog "Preparing to build ShowFoto documentation for: en ${MAKE_DOC}"
		for X in ${MAKE_DOC}; do
			DIRS+="$(ls -d ${X}_showfoto) "
		done
		DIRS="$(echo ${DIRS} | tr '\n' ' ')"
		sed -i -e "s:^SUBDIRS =.*:SUBDIRS = digikam showfoto ${DIRS}:" "${S_DOC}/doc/Makefile.am" || die "sed for locale (docs) failed"
	fi
}

src_compile(){
	local myconf="$(use_enable nfs nfs-hack) --without-included-sqlite3"
	kde_src_compile

	myconf=""
	[[ -d "${S_DOC}" ]] && KDE_S="${S_DOC}" kde_src_compile
}

src_install(){
	kde_src_install
	[[ -d "${S_DOC}" ]] && KDE_S="${S_DOC}" kde_src_install
}
