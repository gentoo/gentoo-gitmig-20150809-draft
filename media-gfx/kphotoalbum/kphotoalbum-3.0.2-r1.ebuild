# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-3.0.2-r1.ebuild,v 1.1 2007/06/17 14:26:02 philantrop Exp $

inherit kde

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://www.kphotoalbum.org/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="arts exif"

LANGS="ar be br ca cs cy da de el en_GB es et fi fr ga gl hi is it ja ka lt mt
nb nds nl pa pl pt pt_BR ro ru rw sk sr sv ta tr uk vi zh_CN"

LANGS_DOC="da de es et fr it nl pt sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

#	kde-base/unsermake
DEPEND="!media-gfx/kimdaba
	exif? ( >=media-libs/libkexif-0.2.3
		>=media-gfx/exiv2-0.9.1 )
	>=media-libs/libkipi-0.1
	|| ( kde-base/kdegraphics-kfile-plugins kde-base/kdegraphics )
	arts? ( kde-base/arts )"

need-kde 3.2

pkg_setup()
{
	setupok=1
	if use exif ; then
		if ! built_with_use =x11-libs/qt-3* sqlite ; then
			elog "To enable KPhotoAlbum to search your images"
			elog "using EXIF information you also need to have"
			elog "Qt installed with SQLite support."
			elog
			elog "Make sure your Qt is installed with the sqlite USE flag."
			setupok=0
		fi
		if [ $setupok != 0 ] ; then
			slot_rebuild "media-libs/libkipi media-libs/libkexif"
			setupok=$?
		fi
	else
		slot_rebuild "media-libs/libkipi"
		setupok=$?
	fi
	if [ $setupok == 0 ] ; then
		die
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

src_compile()
{
	if ! use exif; then
		elog "NOTICE: You have the exif USE flag disabled. ${CATEGORY}/${PN}"
		elog "will be compiled without EXIF support unless you installed"
		elog "media-gfx/exiv2 manually."
		local myconf="--disable-exiv2"
	fi
	kde_src_compile
}
