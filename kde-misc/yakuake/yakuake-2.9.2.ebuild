# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.9.2.ebuild,v 1.1 2008/04/25 15:47:48 tgurr Exp $

EAPI="1"
NEED_KDE="4.0.0"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"
SLOT="kde-4"
PREFIX="${KDEDIR}"

DEPEND="|| ( kde-base/konsole:${SLOT}
		kde-base/kdebase:${SLOT} )"
RDEPEND="${DEPEND}"

LANGS="ca cs da de el en_GB fr ga ja nds nl pt pt_BR ro sv tr uk"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	comment_all_add_subdirectory po/ || die "sed to remove all linguas failed."

	local X
	for X in ${LANGS}; do
		if use linguas_${X}; then
			sed -i -e "/add_subdirectory(\s*${X}\s*)\s*$/ s/^#DONOTCOMPILE //" \
			po/CMakeLists.txt || die "Sed to uncomment linguas_${lang} failed."
		fi
	done

	kde4-base_src_compile
}

src_install() {
	kde4-base_src_install
	dodoc AUTHORS ChangeLog KDE4FAQ NEWS README TODO || die "dodoc failed."
}
