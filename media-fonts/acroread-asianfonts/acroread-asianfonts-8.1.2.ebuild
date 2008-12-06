# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/acroread-asianfonts/acroread-asianfonts-8.1.2.ebuild,v 1.1 2008/12/06 14:33:10 matsuu Exp $

EAPI=2
inherit eutils

SRC_HEAD="http://ardownload.adobe.com/pub/adobe/reader/unix/8.x/8.1.2/misc/FontPack81_"
#SRC_FOOT="_sparc-solaris.tar.gz"
SRC_FOOT="_i486-linux.tar.gz"

DESCRIPTION="Asian and Extended Language Font Packs used by Adobe Reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/acrrasianfontpack.html"
SRC_URI="minimal? (
		linguas_zh_CN? ( ${SRC_HEAD}chs${SRC_FOOT} )
		linguas_zh_TW? ( ${SRC_HEAD}cht${SRC_FOOT} )
		linguas_ja? ( ${SRC_HEAD}jpn${SRC_FOOT} )
		linguas_ko? ( ${SRC_HEAD}kor${SRC_FOOT} )
	)
	!minimal? (
		${SRC_HEAD}chs${SRC_FOOT}
		${SRC_HEAD}cht${SRC_FOOT}
		${SRC_HEAD}jpn${SRC_FOOT}
		${SRC_HEAD}kor${SRC_FOOT}
		${SRC_HEAD}xtd${SRC_FOOT}
	)"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_zh_CN linguas_zh_TW linguas_ja linguas_ko minimal"
RESTRICT="strip mirror"

DEPEND=">=app-text/acroread-${PV}"

S="${WORKDIR}"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"

	if ! built_with_use ">=app-text/acroread-${PV}" linguas_zh_TW && (use linguas_zh_TW || use !minimal); then
		INST_LANG="${INST_LANG} CHT"
	fi

	if ! built_with_use ">=app-text/acroread-${PV}" linguas_ja && (use linguas_ja || use !minimal); then
		INST_LANG="${INST_LANG} JPN"
	fi

	if ! built_with_use ">=app-text/acroread-${PV}" linguas_ko && (use linguas_ko || use !minimal); then
		INST_LANG="${INST_LANG} KOR"
	fi

	if ! built_with_use ">=app-text/acroread-${PV}" linguas_zh_CN && (use linguas_zh_CN || use !minimal); then
		INST_LANG="${INST_LANG} CHS"
	fi

	if [ "${INST_LANG}" = "" ] ; then
		eerror "You don't have to install acroread-asianfonts."
		eerror "Please unmerge acroread-asianfonts."
		einfo "# emerge -C acroread-asianfonts"
		die "You don't have to install acroread-asianfonts."
	fi

}

src_install() {
	local INSTALLDIR="/opt"
	local RESOURCEDIR="${INSTALLDIR}/Adobe/Reader8/Resource"
	local CMAPDIR="${RESOURCEDIR}/CMap"

	dodir "${INSTALLDIR}"
	for lang in ${INST_LANG}
	do
		einfo "Installing ${lang} pack ..."
		tar xf "${lang}KIT/LANG${lang}.TAR" --no-same-owner -C "${D}/${INSTALLDIR}"
	done
	if use !minimal; then
		einfo "Installing extended pack ..."
		tar xf "xtdfont/XTDFONT.TAR" --no-same-owner -C "${D}/${INSTALLDIR}"
		rm "${D}/${RESOURCEDIR}"/Font/{MinionPro*,MyriadPro*}
		rm "${D}/${INSTALLDIR}"/Adobe/Reader8/Reader/intellinux/lib/libicu{data,uc}.so.34.0
		# security issue
		rm "${D}/${INSTALLDIR}"/Adobe/Reader8/Reader/intellinux/lib/libpiaglbreakfinder.so
	fi

	einfo "Installing Asian CMaps ..."
	tar xf ${INST_LANG/* /}KIT/LANGCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
	# tar xf ${INST_LANG/* /}KIT/BINCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"

	# bug 152288
	rm "${D}/${CMAPDIR}"/Identity-{V,H}
	rm "${D}/${INSTALLDIR}"/{INSTALL,LICREAD.TXT}

	if built_with_use ">=app-text/acroread-${PV}" linguas_zh_CN ; then
		rm "${D}/${CMAPDIR}"/{Adobe-GB*,GB*,UCS2-GB*,UniGB*}
	fi
	if built_with_use ">=app-text/acroread-${PV}" linguas_zh_TW ; then
		rm "${D}/${CMAPDIR}"/{Adobe-CNS*,B5*,CNS*,ET*,HK*,UCS2-B5*,UCS-ET*,UniCNS*}
	fi
	if built_with_use ">=app-text/acroread-${PV}" linguas_ja ; then
		rm "${D}/${CMAPDIR}"/{8*,9*,Add*,Adobe-J*,EUC*,Ext*,H,UCS2-9*,UniJ*,UniKS-UTF16*,V}
	fi
	if built_with_use ">=app-text/acroread-${PV}" linguas_ko ; then
		rm "${D}/${CMAPDIR}"/{Adobe-Korea*,KSC*,UCS2-GBK*,UCS2-KSC*,UniKS*}
	fi

	insinto "${RESOURCEDIR}"
	doins ${INST_LANG/* /}KIT/LICREAD.TXT || die

	fowners -R -L --dereference 0:0 "${INSTALLDIR}"
}
