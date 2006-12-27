# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/digikamimageplugins/digikamimageplugins-0.9.0.ebuild,v 1.2 2006/12/27 14:29:46 gustavoz Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit kde

P_DOC="${PN}-doc-0.8.2"
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="DigikamImagePlugins are a collection of plugins for digiKam Image Editor."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2
	mirror://sourceforge/digikam/${P_DOC}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="~media-gfx/digikam-${PV}
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	virtual/opengl"

need-kde 3.5

LANGS="br ca cs cy da de el en_GB es et fr ga he it ja lt mt nb nl nn pa pl pt pt_BR ru rw sr sr@Latn sv ta tr zh_CN"
LANGS_DOC="da de et it nl pt pt_BR sv"


src_unpack(){
	kde_src_unpack

	local MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))
	einfo "Enabling translations for: ${MAKE_PO}"

	local MAKE_DOC_IP=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d))
	einfo "Enabling documentation for: ${MAKE_DOC_IP}"

	local MAKE_DOC
	for i in ${MAKE_DOC_IP} ; do MAKE_DOC="${MAKE_DOC} ${i}_digikamimageplugins" ; done

	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.am || die "sed for locale failed"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC} ${PN}:" ${WORKDIR}/${P_DOC}/doc/Makefile.am || die "sed for locale failed"
}

src_compile(){
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
