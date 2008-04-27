# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.17.0.ebuild,v 1.4 2008/04/27 19:42:28 maekke Exp $

inherit cmake-utils

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="ftp://dl.cihar.com/gammu/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug bluetooth irda mysql postgres nls"

RDEPEND="bluetooth? ( net-wireless/bluez-libs )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	dev-util/dialog"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	dev-util/cmake"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" cs de es it pl ru"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}

	# sys-devel/gettext is needed for creating .mo files
	cd "${S}/locale"
	local lang
	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if ! use linguas_${lang} ; then
			sed -i -e "/^[[:space:]]*${lang}[[:space:]]*$/d" CMakeLists.txt
		fi
	done
}

src_compile() {
	# debug flag is used inside cmake-utils.eclass
	local mycmakeargs="$(cmake-utils_use_with bluetooth Bluez) \
		$(cmake-utils_use_with irda IrDA) \
		$(cmake-utils_use_with mysql MySQL) \
		$(cmake-utils_use_with postgres Postgres) \
		-DENABLE_SHARED=ON"
	cmake-utils_src_compile
}

src_test() {
	LD_LIBRARY_PATH="${WORKDIR}"/${PN}_build/common cmake-utils_src_test
}
