# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.8.1-r1.ebuild,v 1.2 2006/02/15 23:09:26 flameeyes Exp $

inherit kde

P_DOC="${PN}-doc-0.8.0"
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2
	mirror://sourceforge/digikam/${P_DOC}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="nfs"

DEPEND=">=media-libs/libgphoto2-2
	>=media-libs/libkexif-0.2.1
	>=dev-db/sqlite-3
	>=media-libs/libkipi-0.1.1
	media-libs/imlib2
	media-libs/tiff
	sys-libs/gdbm"
RDEPEND="${DEPEND}
	|| ( ( kde-base/kgamma kde-base/kamera ) kde-base/kdegraphics )"

need-kde 3.4

LANGS="bg br ca cs cy da de el en_GB es et fi fr ga gl he hu is it ja lt mk mt nb nl nn pa pl pt pt_BR ro ru rw sl sr sr@Latn sv ta tr zh_CN"
LANGS_DOC_DC="da es et it nl pt_BR pt sv"
LANGS_DOC_SF="da et it nl pt sv"

pkg_setup(){
	slot_rebuild "media-libs/libkipi media-libs/libkexif" && die
}

src_unpack(){
	kde_src_unpack

	local MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))
	einfo "Enabling translations for: ${MAKE_PO}"

	local MAKE_DOC_DC=$(echo $(echo "${LINGUAS} ${LANGS_DOC_DC}" | fmt -w 1 | sort | uniq -d))
	local MAKE_DOC_SF=$(echo $(echo "${LINGUAS} ${LANGS_DOC_SF}" | fmt -w 1 | sort | uniq -d))
	einfo "Enabling documentation for: $(echo $(echo "${MAKE_DOC_DC} ${MAKE_DOC_SF}" | fmt -w 1 | sort -u))"

	local MAKE_DOC
	for i in ${MAKE_DOC_DC} ; do MAKE_DOC="${MAKE_DOC} ${i}_digikam" ; done
	for i in ${MAKE_DOC_SF} ; do MAKE_DOC="${MAKE_DOC} ${i}_showfoto" ; done

	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" ${S}/po/Makefile.am || die "sed for locale failed"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC} ${PN}:" ${WORKDIR}/${P_DOC}/doc/Makefile.am || die "sed for locale failed"
}

src_compile(){
	myconf="$(use_enable nfs nfs-hack)"
	kde_src_compile
	myconf=""
	_S=${S}
	S=${WORKDIR}/${P_DOC}
	cd ${S}
	kde_src_compile
	S=${_S}
}

src_install(){
	kde_src_install
	_S=${S}
	S=${WORKDIR}/${P_DOC}
	cd ${S}
	kde_src_install
	S=${_S}
}
