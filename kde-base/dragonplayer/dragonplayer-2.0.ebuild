# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dragonplayer/dragonplayer-2.0.ebuild,v 1.1 2008/02/18 22:07:30 zlin Exp $

EAPI="1"

SLOT="kde-4"
NEED_KDE=":${SLOT}"

inherit kde4-base

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://dragonplayer.org/"
SRC_URI="http://dragonplayer.org/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS="ar be cs da el es fr ga gl it ja km ko lv nb nds nn oc pl pt pt_BR sv tr
zh_CN zh_TW"

for _X in ${LANGS}; do
	IUSE="${IUSE} linguas_${_X}"
done

PREFIX="${KDEDIR}"

RDEPEND=">=kde-base/kdelibs-4.0.1-r1:${SLOT}
	>=media-libs/xine-lib-1.1.9
	|| ( kde-base/phonon:${SLOT} kde-base/kdebase:${SLOT} )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup() {
	if has_version kde-base/phonon:${SLOT}; then
		KDE4_BUILT_WITH_USE_CHECK="kde-base/phonon:${SLOT} xcb"
	elif has_version kde-base/kdebase:${SLOT}; then
		KDE4_BUILT_WITH_USE_CHECK="kde-base/kdebase:${SLOT} xcb xine"
	else
		die "You don't seem to have either kde-base/phonon:${SLOT} or kde-base/kdebase:${SLOT} installed"
	fi

	kde4-base_pkg_setup
}

src_compile() {
	comment_all_add_subdirectory po/ || die "sed to remove all linguas failed."

	local _X
	for _X in ${LANGS}; do
		if use linguas_${X}; then
			sed -i -e "/add_subdirectory(\s*${X}\s*)\s*$/ s/^#DONOTCOMPILE //" \
				po/CMakeLists.txt || die "sed to uncomment ${lang} failed."
		fi
	done

	kde4-base_src_compile
}
