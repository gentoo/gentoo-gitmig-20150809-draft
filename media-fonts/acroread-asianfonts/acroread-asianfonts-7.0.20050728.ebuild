# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/acroread-asianfonts/acroread-asianfonts-7.0.20050728.ebuild,v 1.6 2007/07/02 15:03:37 peper Exp $

BASE_URI="ftp://ftp.adobe.com/pub/adobe/reader/unix/7x/7.0/misc"

DESCRIPTION="Asian font packs for Adobe Acrobat Reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/acrrasianfontpack.html"
SRC_URI="linguas_zh_CN? ( ${BASE_URI}/chsfont.tar.gz )
	linguas_zh_TW? ( ${BASE_URI}/chtfont.tar.gz )
	linguas_ja? ( ${BASE_URI}/jpnfont.tar.gz )
	linguas_ko? ( ${BASE_URI}/korfont.tar.gz )"

SLOT="0"
LICENSE="Adobe"
KEYWORDS=""
IUSE="linguas_zh_CN linguas_zh_TW linguas_ja linguas_ko"
RESTRICT="mirror"

DEPEND="=app-text/acroread-7*"

S="${WORKDIR}"

pkg_setup() {
	elog
	elog "You need to set LINGUAS to desired font pack name."
	elog "e.g. set LINGUAS=\"ja zh_TW\" to get Japanese and"
	elog "Traditional Chinese font packs. Available LINGUAS"
	elog "are: zh_CN, zh_TW, ja and ko."
	elog
	if ! useq linguas_zh_CN && ! useq linguas_zh_TW && ! useq linguas_ja && ! useq linguas_ko ; then
		die "You need to set LINGUAS variable to emerge ${PN}."
	fi
}

src_install() {
	INSTALLDIR="/opt/Acrobat7/Resource"
	INST_LANG=""
	useq linguas_zh_CN && INST_LANG="${INST_LANG} CHS"
	useq linguas_zh_TW && INST_LANG="${INST_LANG} CHT"
	useq linguas_ja    && INST_LANG="${INST_LANG} JPN"
	useq linguas_ko    && INST_LANG="${INST_LANG} KOR"

	cd ${WORKDIR}
	dodir ${INSTALLDIR}
	for lang in ${INST_LANG}
	do
		einfo "Installing ${lang} pack ..."
		tar xf "${lang}KIT/LANG${lang}.TAR" --no-same-owner -C  ${D}/${INSTALLDIR}
	done

	einfo "Installing Asian CMaps ..."
	tar xf ${INST_LANG/* /}KIT/LANGCOM.TAR --no-same-owner -C ${D}/${INSTALLDIR}

	insinto ${INSTALLDIR}
	doins ${INST_LANG/* /}KIT/LICREAD.TXT || die

	chown -R --dereference 0:0 ${D}/${INSTALLDIR}
}
