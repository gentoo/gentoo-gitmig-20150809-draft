# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.9_beta1.ebuild,v 1.1 2008/01/31 11:47:29 ingmar Exp $

EAPI="1"
NEED_KDE="4.0.0"
inherit kde4-base versionator

MY_P="${PN}-$(replace_version_separator 2 '-')"

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"
SLOT="kde-4"
PREFIX="${KDEDIR}"

DEPEND="
	|| ( kde-base/konsole:${SLOT}
		kde-base/kdebase:${SLOT} )"
RDEPEND="${DEPEND}"

LANGS="de el fr ga ja nds"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

S=${WORKDIR}/${MY_P}

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
	dodoc KDE4FAQ || die "dodoc failed."
}
