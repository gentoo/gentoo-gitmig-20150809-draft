# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.1.4.ebuild,v 1.10 2003/12/04 15:54:48 caleb Exp $

inherit kde
need-kde ${PV}

DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="$KDEMAJORVER.$KDEMINORVER"
RESTRICT="nomirror"

newdepend="$newdepend >=sys-apps/portage-2.0.49-r8"

LANGS="af ar bg bs ca cs da de el es en_GB eo es et eu fa fi fr he hr hu is it
ja lt mk mt nb nl nn nso pl pt ro ru se sk sl sr ss sv ta th tr uk ven vi xh zu"

echo "$USE"

BASEDIR="mirror://kde/stable/${PV}/src/kde-i18n"
SRC_URI="linguas_af? ( ${BASEDIR}/kde-i18n-af-${PV}.tar.bz2 )
	linguas_ar? ( ${BASEDIR}/kde-i18n-ar-${PV}.tar.bz2 )
	linguas_bg? ( ${BASEDIR}/kde-i18n-bg-${PV}.tar.bz2 )
	linguas_bs? ( ${BASEDIR}/kde-i18n-bs-${PV}.tar.bz2 )
	linguas_ca? ( ${BASEDIR}/kde-i18n-ca-${PV}.tar.bz2 )
	linguas_cs? ( ${BASEDIR}/kde-i18n-cs-${PV}.tar.bz2 )
	linguas_da? ( ${BASEDIR}/kde-i18n-da-${PV}.tar.bz2 )
	linguas_de? ( ${BASEDIR}/kde-i18n-de-${PV}.tar.bz2 )
	linguas_el? ( ${BASEDIR}/kde-i18n-el-${PV}.tar.bz2 )
	linguas_es? ( ${BASEDIR}/kde-i18n-es-${PV}.tar.bz2 )
#	linguas_en_GB? ( ${BASEDIR}/kde-i18n-en_GB-${PV}.tar.bz2 )
	linguas_eo? ( ${BASEDIR}/kde-i18n-eo-${PV}.tar.bz2 )
	linguas_es? ( ${BASEDIR}/kde-i18n-es-${PV}.tar.bz2 )
	linguas_et? ( ${BASEDIR}/kde-i18n-et-${PV}.tar.bz2 )
	linguas_eu? ( ${BASEDIR}/kde-i18n-eu-${PV}.tar.bz2 )
	linguas_fa? ( ${BASEDIR}/kde-i18n-fa-${PV}.tar.bz2 )
	linguas_fi? ( ${BASEDIR}/kde-i18n-fi-${PV}.tar.bz2 )
	linguas_fr? ( ${BASEDIR}/kde-i18n-fr-${PV}.tar.bz2 )
	linguas_he? ( ${BASEDIR}/kde-i18n-he-${PV}.tar.bz2 )"

#
# Define the LINGUAS environment variable to contain which language(s) you would
# like for this ebuild to download and install.
#

src_unpack() {

	einfo "Hi"

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

