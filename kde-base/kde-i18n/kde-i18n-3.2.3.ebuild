# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.2.3.ebuild,v 1.3 2004/07/21 20:45:51 caleb Exp $

inherit kde
MY_PV=${PV}

IUSE=""
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~amd64 ~ppc ~alpha ~ia64"
SLOT="$KDEMAJORVER.$KDEMINORVER"
RESTRICT="nomirror"
DEPEND="~kde-base/kdebase-${PV}
	>=sys-apps/portage-2.0.49-r8"
need-kde ${PV}

SRC_URI="linguas_ar? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ar-${PV}.tar.bz2 )
	linguas_az? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-az-${PV}.tar.bz2 )
	linguas_bg? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-bg-${PV}.tar.bz2 )
	linguas_bn? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-bn-${PV}.tar.bz2 )
	linguas_bs? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-bs-${PV}.tar.bz2 )
	linguas_ca? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ca-${PV}.tar.bz2 )
	linguas_cs? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-cs-${PV}.tar.bz2 )
	linguas_cy? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-cy-${PV}.tar.bz2 )
	linguas_da? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-da-${PV}.tar.bz2 )
	linguas_de? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-de-${PV}.tar.bz2 )
	linguas_el? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-el-${PV}.tar.bz2 )
	linguas_en_GB? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-en_GB-${PV}.tar.bz2 )
	linguas_es? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-es-${PV}.tar.bz2 )
	linguas_et? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-et-${PV}.tar.bz2 )
	linguas_eu? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-eu-${PV}.tar.bz2 )
	linguas_fa? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-fa-${PV}.tar.bz2 )
	linguas_fi? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-fi-${PV}.tar.bz2 )
	linguas_fr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-fr-${PV}.tar.bz2 )
	linguas_gl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-gl-${PV}.tar.bz2 )
	linguas_he? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-he-${PV}.tar.bz2 )
	linguas_hi? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-hi-${PV}.tar.bz2 )
	linguas_hr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-hr-${PV}.tar.bz2 )
	linguas_hsb? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-hsb-${PV}.tar.bz2 )
	linguas_hu? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-hu-${PV}.tar.bz2 )
	linguas_is? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-is-${PV}.tar.bz2 )
	linguas_it? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-it-${PV}.tar.bz2 )
	linguas_ja? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ja-${PV}.tar.bz2 )
	linguas_lt? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-lt-${PV}.tar.bz2 )
	linguas_mn? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-mn-${PV}.tar.bz2 )
	linguas_ms? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ms-${PV}.tar.bz2 )
	linguas_nb? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nb-${PV}.tar.bz2 )
	linguas_nds? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nds-${PV}.tar.bz2 )
	linguas_nl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nl-${PV}.tar.bz2 )
	linguas_nn? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-nn-${PV}.tar.bz2 )
	linguas_pl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-pl-${PV}.tar.bz2 )
	linguas_pt? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-pt-${PV}.tar.bz2 )
	linguas_pt_BR? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-pt_BR-${PV}.tar.bz2 )
	linguas_ro? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ro-${PV}.tar.bz2 )
	linguas_ru? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ru-${PV}.tar.bz2 )
	linguas_se? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-se-${PV}.tar.bz2 )
	linguas_sk? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sk-${PV}.tar.bz2 )
	linguas_sl? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sl-${PV}.tar.bz2 )
	linguas_sr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sr-${PV}.tar.bz2 )
	linguas_sv? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sv-${PV}.tar.bz2 )
	linguas_ta? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-ta-${PV}.tar.bz2 )
	linguas_tr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-tr-${PV}.tar.bz2 )
	linguas_uk? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-uk-${PV}.tar.bz2 )
	linguas_uz? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-uz-${PV}.tar.bz2 )
	linguas_zh_CN? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-zh_CN-${PV}.tar.bz2 )
	linguas_zh_TW? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-zh_TW-${PV}.tar.bz2 )"

src_unpack() {

	if [ -z "${LINGUAS}" ]; then
		ewarn
		ewarn "You must define a LINGUAS environment variable that contains a list"
		ewarn "of the language codes for which languages you would like to install."
		ewarn "e.g.: LINGUAS=\"se de pt\""
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

