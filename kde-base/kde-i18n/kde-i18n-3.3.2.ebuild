# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.3.2.ebuild,v 1.14 2006/06/01 19:51:59 greg_g Exp $

inherit kde eutils

MY_PV=${PV}
#MY_PV=3.3

IUSE=""
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc ppc ppc64 hppa alpha"
SLOT="$KDEMAJORVER.$KDEMINORVER"

DEPEND="~kde-base/kdebase-${PV}
	>=sys-apps/portage-2.0.49-r8"
need-kde ${PV}

SRC_URI="linguas_sr? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-sr@Latn-${PV}.tar.bz2 )"

LANGS="af ar bg bn bs ca cs cy da de el en_GB eo es et eu fa fi fr gl he hi hr hsb hu is it ja mn ms nb nds nl nn pa pl pt pt_BR ro ru sk sl sr sr@Latn sv ta tg tr uk uz zh_CN zh_TW"

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://kde/stable/${MY_PV}/src/kde-i18n/kde-i18n-${X}-${PV}.tar.bz2 )"
done

pkg_setup() {
	if [ -z "${A}" ]; then
		echo
		eerror "You must define a LINGUAS environment variable that contains a list"
		eerror "of the language codes for which languages you would like to install."
		eerror "Look at the LANGS variable inside the ebuild to see the list of"
		eerror "available languages."
		eerror "e.g.: LINGUAS=\"sv de pt\""
		echo
		die
	fi
}

src_unpack() {
	base_src_unpack unpack
	cd ${WORKDIR}
	use linguas_ru && epatch ${FILESDIR}/kde-i18n-ru-3.3.2-kmplot.diff
}

src_compile() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		S=${WORKDIR}/$dir
		KDE_S=$S
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

