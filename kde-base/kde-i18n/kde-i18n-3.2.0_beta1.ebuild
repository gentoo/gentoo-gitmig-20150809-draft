# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.2.0_beta1.ebuild,v 1.3 2003/11/17 18:12:27 caleb Exp $

inherit kde
need-kde ${PV}
MY_PV=3.1.93

DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="$KDEMAJORVER.$KDEMINORVER"
RESTRICT="nomirror"

newdepend="$newdepend >=sys-apps/portage-2.0.49-r8"

LANGS="af ar az be bg br bs ca cs cy da de el en_GB eo es et eu fa fi fo fr ga gl
he hr hu id is it ja ko ku lo lt lv mi mn mk mt nb nl nn nso oc pl pt pt_BR ro ru
se sk sl sr ss sv ta th tr uk uz ven vi wa wen xh zh_CN zh_TW zu"

#
# Define the LINGUAS environment variable to contain which language(s) you would
# like for this ebuild to download and install.
#

BASEDIR="mirror://kde/unstable/${MY_PV}/src/kde-i18n"

for pkg in $LANGS
do
	SRC_URI="$SRC_URI linguas_${pkg}? ( $BASEDIR/kde-i18n-${pkg}-${MY_PV}.tar.bz2 )"
done

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

