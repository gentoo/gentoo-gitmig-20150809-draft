# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.9.3.ebuild,v 1.6 2008/05/19 00:17:12 carlo Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
P_DOC="${PN}-doc-0.9.2-beta2"
S_DOC="${WORKDIR}/${P_DOC}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/${P_DOC}.tar.bz2 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="nfs doc kdehiddenvisibility kdeenablefinal"

DEPEND=">=media-libs/libgphoto2-2.2
	>=dev-db/sqlite-3
	>=media-libs/libkipi-0.1.5
	>=media-libs/tiff-3.8.2
	>=media-libs/lcms-1.14
	>=media-libs/libpng-1.2
	>=media-libs/jasper-1.7
	>=media-libs/libkexiv2-0.1.6
	>=media-libs/libkdcraw-0.1.2
	media-libs/jasper
	!media-plugins/digikamimageplugins"

RDEPEND="${DEPEND}
	|| ( ( =kde-base/kgamma-3.5* =kde-base/kamera-3.5* )
		=kde-base/kdegraphics-3.5* )"

need-kde 3.5

LANGS="ar bg br ca cs cy da de el en_GB es et fa fi fr gl he hu is it ja ka lt
mk ms mt nb nds nl nn pa pl pt pt_BR ro ru rw sk sl sr sr@Latn sv ta th tr uk vi
zh_CN zh_TW"

LANGS_DOC="da de es et fr it nl pl pt pt_BR ru sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_unpack(){
	kde_src_unpack

	epatch "${FILESDIR}/${PN}-lcms-1.17.patch"

	rm -f "${S}/configure" "${S_DOC}/configure"

	local MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
	elog "Enabling translations for: en ${MAKE_PO}"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" "${S}/po/Makefile.am" || die "sed for locale failed"

	if use doc; then
		local MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
		elog "Enabling documentation for: en ${MAKE_DOC}"
		cd "${S_DOC}/doc"
		for X in ${MAKE_DOC}; do
			DIRS+="$(ls -d ${X}*) "
		done
		DIRS="$(echo ${DIRS} | tr '\n' ' ')"
		sed -i -e "s:^SUBDIRS =.*:SUBDIRS = digikam ${DIRS}:" "${S_DOC}/doc/Makefile.am" || die "sed for locale (docs) failed"
	fi
}

src_compile(){
	local myconf

	myconf="$(use_enable nfs nfs-hack)"
	kde_src_compile
	myconf=""
	[[ -d "${S_DOC}" ]] && KDE_S="${S_DOC}" kde_src_compile
}

src_install(){
	kde_src_install
	[[ -d "${S_DOC}" ]] && KDE_S="${S_DOC}" kde_src_install
}
