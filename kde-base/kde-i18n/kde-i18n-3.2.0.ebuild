# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.2.0.ebuild,v 1.2 2004/02/04 12:55:41 caleb Exp $

inherit kde
need-kde ${PV}
MY_PV=3.2

IUSE=""
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"
SLOT="$KDEMAJORVER.$KDEMINORVER"
RESTRICT="nomirror"
DEPEND="~kde-base/kdebase-${PV}
	>=sys-apps/portage-2.0.49-r8"

SRC_URI="linguas_az? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-az-${MY_PV}.tar.bz2 )
	linguas_bg? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-bg-${MY_PV}.tar.bz2 )
	linguas_bs? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-bs-${MY_PV}.tar.bz2 )
	linguas_ca? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ca-${MY_PV}.tar.bz2 )
	linguas_cs? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-cs-${MY_PV}.tar.bz2 )
	linguas_cy? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-cy-${MY_PV}.tar.bz2 )
	linguas_da? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-da-${MY_PV}.tar.bz2 )
	linguas_de? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-de-${MY_PV}.tar.bz2 )
	linguas_el? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-el-${MY_PV}.tar.bz2 )
	linguas_en_GB? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-en_GB-${MY_PV}.tar.bz2 )
	linguas_es? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-es-${MY_PV}.tar.bz2 )
	linguas_et? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-et-${MY_PV}.tar.bz2 )
	linguas_eu? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-eu-${MY_PV}.tar.bz2 )
	linguas_fa? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-fa-${MY_PV}.tar.bz2 )
	linguas_fi? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-fi-${MY_PV}.tar.bz2 )
	linguas_fr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-fr-${MY_PV}.tar.bz2 )
	linguas_gl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-gl-${MY_PV}.tar.bz2 )
	linguas_he? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-he-${MY_PV}.tar.bz2 )
	linguas_hi? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-hi-${MY_PV}.tar.bz2 )
	linguas_hu? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-hu-${MY_PV}.tar.bz2 )
	linguas_it? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-it-${MY_PV}.tar.bz2 )
	linguas_mn? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-mn-${MY_PV}.tar.bz2 )
	linguas_ms? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ms-${MY_PV}.tar.bz2 )
	linguas_nb? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nb-${MY_PV}.tar.bz2 )
	linguas_nl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nl-${MY_PV}.tar.bz2 )
	linguas_nn? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nn-${MY_PV}.tar.bz2 )
	linguas_pl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-pl-${MY_PV}.tar.bz2 )
	linguas_pt? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-pt-${MY_PV}.tar.bz2 )
	linguas_pt_BR? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-pt_BR-${MY_PV}.tar.bz2 )
	linguas_ro? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ro-${MY_PV}.tar.bz2 )
	linguas_ru? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ru-${MY_PV}.tar.bz2 )
	linguas_se? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-se-${MY_PV}.tar.bz2 )
	linguas_sk? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sk-${MY_PV}.tar.bz2 )
	linguas_sl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sl-${MY_PV}.tar.bz2 )
	linguas_sr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sr-${MY_PV}.tar.bz2 )
	linguas_st? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-st-${MY_PV}.tar.bz2 )
	linguas_sv? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sv-${MY_PV}.tar.bz2 )
	linguas_ta? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ta-${MY_PV}.tar.bz2 )
	linguas_tr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-tr-${MY_PV}.tar.bz2 )
	linguas_uk? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-uk-${MY_PV}.tar.bz2 )
	linguas_uz? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-uz-${MY_PV}.tar.bz2 )
	linguas_zh_CN? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-zh_CN-${MY_PV}.tar.bz2 )
	linguas_zh_TW? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-zh_TW-${MY_PV}.tar.bz2 )"

src_unpack() {

	if [ -z ${LINGUAS} ]; then
		ewarn
		ewarn "You must define a LINGUAS environment variable that contains a list"
		ewarn "of the country codes for which languages you would like to install."
		ewarn
		die
	fi

	base_src_unpack unpack
}

src_compile() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		S=${WORKDIR}/$dir
		kde_src_compile myconf
		myconf="$myconf --prefix=$KDEDIR -C"
		kde_src_compile configure
		kde_src_compile make
	done
	S=${_S}
}

src_install() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/$dir
		make install DESTDIR=${D} destdir=${D}
	done
	S=${_S}
}

