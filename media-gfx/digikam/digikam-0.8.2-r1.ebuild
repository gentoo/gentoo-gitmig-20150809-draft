# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.8.2-r1.ebuild,v 1.7 2007/03/31 15:51:04 armin76 Exp $

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
P_DOC="${PN}-doc-${PV}"
S_DOC="${WORKDIR}/${P_DOC}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE="nfs doc kdehiddenvisibility"

DEPEND=">=media-libs/libgphoto2-2
	>=media-libs/libkexif-0.2.1
	>=dev-db/sqlite-3
	>=media-libs/libkipi-0.1.1
	media-libs/imlib2
	media-libs/tiff
	sys-libs/gdbm
	media-gfx/dcraw"
RDEPEND="${DEPEND}
	|| ( ( kde-base/kgamma kde-base/kamera ) kde-base/kdegraphics )"

need-kde 3.4

LANGS="bg bn br ca cs cy da de el en_GB es et eu fi fr ga gl he hu is it ja km
lt mk ms mt nb nl nn pa pl pt pt_BR ro ru rw sl sr sr@Latn sv ta tr uk vi zh_CN"
LANGS_DOC="da de es et fr it nl pl pt pt_BR sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

for lang in ${LANGS_DOC}; do
	SRC_URI="${SRC_URI}
	linguas_${lang}? ( http://gentoo-sunrise.org/svndump/peper/distfiles/${P_DOC}-${lang}.tar.bz2 )"
done

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
		doc? ( http://gentoo-sunrise.org/svndump/peper/distfiles/${P_DOC}-main.tar.bz2
		${SRC_URI} )"

pkg_setup(){
	slot_rebuild "media-libs/libkipi media-libs/libkexif" && die
	kde_pkg_setup
}

src_unpack(){
	kde_src_unpack
	rm -f "${S}/configure" "${S_DOC}/configure"

	local MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
	einfo "Enabling translations for: en ${MAKE_PO}"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" "${S}/po/Makefile.am" || die "sed for locale failed"

	if use doc; then
		local MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
		einfo "Enabling documentation for: en ${MAKE_DOC}"
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

	# Install the .desktop in FDO's suggested directory
	dodir /usr/share/applications/kde
	mv "${D}/usr/share/applnk/Graphics/digikam.desktop" \
		"${D}/usr/share/applications/kde"
}

