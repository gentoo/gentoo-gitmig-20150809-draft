# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.1.5.ebuild,v 1.3 2004/03/25 22:56:22 jhuebel Exp $

inherit kde

DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64"
SLOT="$KDEMAJORVER.$KDEMINORVER"
RESTRICT="nomirror"

DEPEND="~kde-base/kdebase-${PV}
	>=sys-apps/portage-2.0.49-r8"

LANGS="af ar bg bs ca cs da de el es en_GB eo es et eu fa fi fr he hr hu is it
ja lt mk mt nb nl nn nso pl pt pt_BR ro ru se sk sl sr ss sv ta th tr uk ven vi xh
zh_CN zh_TW zu"

#
# Define the LINGUAS environment variable to contain which language(s) you would
# like for this ebuild to download and install.
#

BASEDIR="mirror://kde/stable/${PV}/src/kde-i18n"

for pkg in $LANGS
do
	SRC_URI="$SRC_URI linguas_${pkg}? ( $BASEDIR/kde-i18n-${pkg}-${PV}.tar.bz2 )"
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

