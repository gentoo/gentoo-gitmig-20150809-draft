# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/acroread-asianfonts/acroread-asianfonts-5.0.20020815.ebuild,v 1.1 2005/03/28 15:09:50 usata Exp $

BASE_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/"

DESCRIPTION="Asian font packs for Adobe Acrobat Reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/acrrasianfontpack.html"
SRC_URI="linguas_zh_CN? ( ${BASE_URI}/chsfont.tar.gz )
	linguas_zh_TW? ( ${BASE_URI}/chtfont.tar.gz )
	linguas_ja? ( ${BASE_URI}/jpnfont.tar.gz )
	linguas_ko? ( ${BASE_URI}/korfont.tar.gz )"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND="=app-text/acroread-5*"

S="${WORKDIR}"

pkg_setup() {
	einfo
	einfo "You need to set LINGUAS to desired font pack name."
	einfo "e.g. set LINGUAS=\"ja zh_TW\" to get Japanese and"
	einfo "Traditional Chinese font packs. Available LINGUAS"
	einfo "are: zh_CN, zh_TW, ja and ko."
	einfo
	if ! useq linguas_zh_CN && ! useq linguas_zh_TW && ! useq linugas_ja && useq linguas_ko ; then
		die "You need to set LINGUAS variable to emerge ${PN}."
	fi
}

src_install() {
	INSTALLDIR="/opt/Acrobat5/Resource"
	INST_LANG=""
	useq linguas_zh_CN && INST_LANG="${INST_LANG} CHS"
	useq linguas_zh_CN && INST_LANG="${INST_LANG} CHT"
	useq linguas_ja    && INST_LANG="${INST_LANG} JPN"
	useq linguas_ko    && INST_LANG="${INST_LANG} KOR"

	cd ${WORKDIR}
	dodir ${INSTALLDIR}/Font
	for lang in ${INST_LANG}
	do
		einfo "Installing ${lang} pack ..."
		tar xf "${lang}KIT/LANG${lang}.TAR" --no-same-owner -C  ${D}/${INSTALLDIR}/Font
	done

	einfo "Installing Asian CMaps ..."
	tar xf ${INST_LANG/* /}KIT/LANGCOM.TAR --no-same-owner -C ${D}/${INSTALLDIR}/Font

	insinto ${INSTALLDIR}/Font
	doins ${INST_LANG/* /}KIT/LICFONT.TXT

	chown -R --dereference 0:0 ${D}/${INSTALLDIR}
}
