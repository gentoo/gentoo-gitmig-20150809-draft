# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.4.0_beta2.ebuild,v 1.1 2005/02/09 16:25:23 greg_g Exp $

inherit kde eutils

MY_PV=3.3.92

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~x86"
IUSE=""
SLOT="${KDEMAJORVER}.${KDEMINORVER}"

need-kde ${PV}

LANGS="af ar az be bg bn bs ca cs cy da de el en_GB eo es et eu fa \
	fi fo fr gl he hi hr hsb hu is it ja ko ku lt lv mk mn ms mt \
	nb nds nl nn nso pa pl pt pt_BR ro ru se sk sl sr sr@Latn ss \
	sv ta tg th tr uk uz ven vi wa xh zh_CN zh_TW zu"

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://kde/unstable/${MY_PV}/src/kde-i18n/kde-i18n-${X}-${MY_PV}.tar.bz2 )"
done

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
		S=${WORKDIR}/${dir}

		kde_src_compile myconf
		myconf="${myconf} --prefix=${KDEDIR}"
		kde_src_compile configure
		kde_src_compile make
	done
	S=${_S}
}

src_install() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/${dir}
		make DESTDIR=${D} install
	done
	S=${_S}
}
