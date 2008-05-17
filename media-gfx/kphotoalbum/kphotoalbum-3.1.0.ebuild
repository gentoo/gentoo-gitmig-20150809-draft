# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-3.1.0.ebuild,v 1.7 2008/05/17 15:59:12 carlo Exp $

inherit kde

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://www.kphotoalbum.org/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="arts exif raw"

LANGS="ar be br ca cs cy da de el en_GB es et fi fr ga gl hi is it ja ka lt mt
nb nds nl pa pl pt pt_BR ro ru rw sk sr sr@Latn sv ta tr uk vi zh_CN"

LANGS_DOC="da de es et fr it nl pt sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

DEPEND="arts? ( =kde-base/arts-3.5* )
	exif? ( >=media-gfx/exiv2-0.15 )
	raw? ( >=media-libs/libkdcraw-0.1.1 )
	>=media-libs/jpeg-6b-r7
	>=media-libs/libkipi-0.1
	|| ( =kde-base/kdegraphics-3.5* =kde-base/kdegraphics-kfile-plugins-3.5* )"

need-kde 3.5

PATCHES="${FILESDIR}/${P}-exiv2.patch"

pkg_setup() {
	if use exif ; then
		if ! built_with_use =x11-libs/qt-3* sqlite ; then
			elog "To enable KPhotoAlbum to search your images"
			elog "using EXIF information you also need to have"
			elog "Qt installed with SQLite support."
			elog
			elog "Make sure your Qt is installed with the sqlite USE flag."
			die
		fi
	fi
}

src_unpack() {
	kde_src_unpack

	# Adapted from kde.eclass
	if [[ -z ${LINGUAS} ]]; then
		elog "You can drop some of the translations of the interface and"
		elog "documentation by setting the \${LINGUAS} variable to the"
		elog "languages you want installed."
		elog
		elog "Enabling all languages"
	else
		if [[ -n ${LANGS} ]]; then
			MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | tr ' ' '\n' | sort | uniq -d))
			elog "Enabling translations for: ${MAKE_PO}"
			sed -i -e "s:^SUBDIRS=.*:SUBDIRS = ${MAKE_PO}:" "${KDE_S}/translations/Makefile.am" \
				|| die "sed for locale failed"
			rm -f "${KDE_S}/configure"
		fi

		if [[ -n ${LANGS_DOC} ]]; then
			MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | tr ' ' '\n' | sort | uniq -d))
			elog "Enabling documentation for: ${MAKE_DOC}"
			elog "(If some languages you chose are missing, it's because there's no translation for them.)"
		fi
	fi
}

src_compile() {
	local myconf="$(use_enable raw kdcraw)"
	if ! use exif; then
		elog "NOTICE: You have the exif USE flag disabled. ${CATEGORY}/${PN}"
		elog "will be compiled without EXIF support."
		myconf="${myconf} --disable-exiv2"
	fi
	kde_src_compile
}
