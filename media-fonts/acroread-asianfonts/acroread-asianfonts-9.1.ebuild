# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/acroread-asianfonts/acroread-asianfonts-9.1.ebuild,v 1.4 2009/10/25 11:52:30 maekke Exp $

EAPI="2"
inherit confutils

SRC_PREFIX="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/9.1/misc/FontPack910_"
#SRC_SUFFIX="_i386-solaris.tar.bz2"
SRC_SUFFIX="_i486-linux.tar.bz2"

DESCRIPTION="Asian and Extended Language Font Packs used by Adobe Reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/acrrasianfontpack.html"
SRC_URI="!minimal? ( ${SRC_PREFIX}xtd${SRC_SUFFIX} )
	linguas_ja? ( ${SRC_PREFIX}jpn${SRC_SUFFIX} )
	linguas_ko? ( ${SRC_PREFIX}kor${SRC_SUFFIX} )
	linguas_zh_CN? ( ${SRC_PREFIX}chs${SRC_SUFFIX} )
	linguas_zh_TW? ( ${SRC_PREFIX}cht${SRC_SUFFIX} )"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="amd64 x86"
IUSE="minimal linguas_ja linguas_ko linguas_zh_CN linguas_zh_TW"
RESTRICT="strip mirror"

DEPEND=""
RDEPEND="linguas_ja? ( >=app-text/acroread-9.1[-linguas_ja] )"
#	linguas_ko? ( >=app-text/acroread-9.1[-linguas_ko] )
#	linguas_zh_CN? ( >=app-text/acroread-9.1[-linguas_zh_CN] )
#	linguas_zh_TW? ( >=app-text/acroread-9.1[-linguas_zh_TW] )

S="${WORKDIR}"

pkg_setup() {
	confutils_require_any !minimal linguas_ja linguas_ko linguas_zh_CN linguas_zh_TW
}

src_install() {
	local INSTALLDIR="/opt"
	local READERDIR="${INSTALLDIR}/Adobe/Reader9"
	local RESOURCEDIR="${READERDIR}/Resource"
	local CMAPDIR="${RESOURCEDIR}/CMap"

	dodir "${INSTALLDIR}"
	insinto "${RESOURCEDIR}"

	if use linguas_ja ; then
		tar xf JPNKIT/LANGCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		tar xf JPNKIT/LANGJPN.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		doins JPNKIT/LICREAD.TXT || die
	fi
	if use linguas_ko ; then
		tar xf KORKIT/LANGCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		tar xf KORKIT/LANGKOR.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		doins KORKIT/LICREAD.TXT || die
	fi
	if use linguas_zh_CN ; then
		tar xf CHSKIT/LANGCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		tar xf CHSKIT/LANGCHS.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		doins CHSKIT/LICREAD.TXT || die
	fi
	if use linguas_zh_TW ; then
		tar xf CHTKIT/LANGCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		tar xf CHTKIT/LANGCHT.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		doins CHTKIT/LICREAD.TXT || die
	fi

	if use !minimal ; then
		tar xf xtdfont/XTDFONT.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
		rm "${D}${RESOURCEDIR}"/Font/{MinionPro*,MyriadPro*}

		doins "${D}${INSTALLDIR}"/LICREAD.TXT || die
		rm "${D}${INSTALLDIR}"/{INSTALL,LICREAD.TXT}
		rm -rf "${D}${READERDIR}"/Reader/intellinux
	fi

	# collision with app-text/acroread, bug #152288
	if use linguas_ja || use linguas_ko \
			|| use linguas_zh_CN || use linguas_zh_TW; then

		rm "${D}/${CMAPDIR}"/Identity-{V,H}

		if use !linguas_ja ; then
			rm "${D}/${CMAPDIR}"/{8*,9*,Add*,Adobe-J*,EUC*,Ext*,H,UCS2-9*,UniJ*,UniKS-UTF16*,V}
		fi
		#if use !linguas_ko ; then
		#	rm "${D}/${CMAPDIR}"/{Adobe-Korea*,KSC*,UCS2-GBK*,UCS2-KSC*,UniKS*}
		#fi
		#if use !linguas_zh_CN ; then
		#	rm "${D}/${CMAPDIR}"/{Adobe-GB*,GB*,UCS2-GB*,UniGB*}
		#fi
		#if use !linguas_zh_TW ; then
		#	rm "${D}/${CMAPDIR}"/{Adobe-CNS*,B5*,CNS*,ET*,HK*,UCS2-B5*,UCS-ET*,UniCNS*}
		#fi
	fi

	fowners -R -L --dereference 0:0 "${INSTALLDIR}"
}
