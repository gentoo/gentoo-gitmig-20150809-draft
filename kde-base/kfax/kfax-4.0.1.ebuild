# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfax/kfax-4.0.1.ebuild,v 1.1 2008/03/11 00:03:32 philantrop Exp $

EAPI="1"

NEED_KDE="${PV}"
inherit kde4-base

# old versions of kfax are versioned like kde (up to 3.5.8). this is newer and
# hence we need a higher version (4.0.1).
MY_PV="3.3.6"
DESCRIPTION="KDE G3/G4 fax viewer"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${PN}-${MY_PV}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="kde-4"
IUSE=""

LANGS="af ar be bg br ca cs cy da de el en_GB eo es et eu fa fi fr ga gl he hr
hu is it ja km ko lt lv mk ms nb nds ne nl nn oc pa pl pt pt_BR ro ru se sk sl
sr sv ta tg th tr uk vi wa xh zh_CN zh_HK zh_TW"

for _X in ${LANGS}; do
	IUSE="${IUSE} linguas_${_X}"
done

PREFIX="${KDEDIR}"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${PN}-${MY_PV}"

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
