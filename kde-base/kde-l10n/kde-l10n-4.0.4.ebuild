# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-l10n/kde-l10n-4.0.4.ebuild,v 1.1 2008/05/15 22:58:52 ingmar Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/gettext-0.15"
RDEPEND=""

LANGS="ar be bg ca cs csb da de el en_GB eo es et eu fa fi fr fy ga gl hi hu
is it ja kk km ko lv mk nb nds ne nl nn pa pl pt pt_BR ru se sl sv th tr uk wa
zh_CN zh_TW"

URI_BASE="${SRC_URI/-${PV}.tar.bz2/}"
SRC_URI=""

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
	SRC_URI="${SRC_URI} linguas_${X}? ( ${URI_BASE}/${PN}-${X}-${PV}.tar.bz2 )"
done

S="${WORKDIR}"

src_unpack() {
	if [[ -z ${A} ]]; then
		echo
		ewarn "You either have the LINGUAS variable unset, or it only"
		ewarn "contains languages not supported by ${P}."
		ewarn "You won't have any additional language support."
		echo
		ewarn "${P} supports these language codes:"
		ewarn "${LANGS}"
		echo
	fi

	[[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# Create a top-level CMakeLists.txt to include the selected LINGUAS as sub-directories of ${S}
	for dir in * ; do
		[[ -d ${dir} ]] && echo "add_subdirectory( ${dir} )" >> "${S}"/CMakeLists.txt
	done
}

src_compile() {
	if [[ -n ${A} ]]; then
		kde4-base_src_compile
	fi
}

src_install() {
	if [[ -n ${A} ]]; then
		kde4-base_src_install
	fi
}
