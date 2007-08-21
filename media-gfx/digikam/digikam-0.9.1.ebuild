# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.9.1.ebuild,v 1.11 2007/08/21 00:22:52 philantrop Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
P_DOC="${PN}-doc-0.8.2"
S_DOC="${WORKDIR}/${P_DOC}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
IUSE="nfs doc kdehiddenvisibility kdeenablefinal"

DEPEND=">=media-libs/libgphoto2-2.2
	>=dev-db/sqlite-3
	>=media-libs/libkipi-0.1
	>=media-libs/tiff-3.8.2
	>=media-gfx/exiv2-0.12
	<media-libs/lcms-1.17
	>=media-libs/libpng-1.2
	>=media-libs/jasper-1.7
	media-libs/libkexiv2"

RDEPEND="${DEPEND}
	|| ( ( kde-base/kgamma kde-base/kamera ) kde-base/kdegraphics )"

need-kde 3.5

LANGS="ar bg br ca cs cy da de el en_GB es et fi fr ga gl he hu is it ja ka lt
mk ms mt nb nl nn pa pl pt pt_BR ro ru rw sk sl sr sr@Latn sv ta th tr uk vi zh_CN
zh_TW"

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
	slot_rebuild "media-libs/libkipi" && die
	kde_pkg_setup
}

src_unpack(){
	kde_src_unpack
	rm -f "${S}/configure" "${S_DOC}/configure"

	if has_version ">=media-gfx/exiv2-0.14"; then
		epatch "${FILESDIR}/${P}-exiv2.patch"
	fi

	local MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
	elog "Enabling translations for: en ${MAKE_PO}"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" "${S}/po/Makefile.am" || die "sed for locale failed"

	if use doc; then
		local MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
		elog "Enabling documentation for: en ${MAKE_DOC}"
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
