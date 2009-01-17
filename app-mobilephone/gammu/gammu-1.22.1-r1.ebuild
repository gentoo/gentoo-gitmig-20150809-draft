# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.22.1-r1.ebuild,v 1.1 2009/01/17 14:24:04 mrness Exp $

inherit cmake-utils

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="ftp://dl.cihar.com/gammu/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug bluetooth irda mysql postgres nls"

RDEPEND="bluetooth? ( net-wireless/bluez-libs )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	dev-util/dialog"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	dev-util/cmake"

# sys-devel/gettext is needed for creating .mo files
# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" cs de es id it pl ru"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-assert.patch
	epatch "${FILESDIR}"/${P}-skip-locktest.patch

	pushd "${S}"/locale || die "locale directory not found"
	local lang support_linguas=no
	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if use linguas_${lang} ; then
			support_linguas=yes
			break
		fi
	done
	# install all languages when all selected LINGUAS aren't supported
	if [ "${support_linguas}" = "yes" ]; then
		for lang in ${MY_AVAILABLE_LINGUAS} ; do
			if ! use linguas_${lang} ; then
				sed -i -e "/^[[:space:]]*${lang}[[:space:]]*$/d" CMakeLists.txt
			fi
		done
	fi
	popd
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

pkg_preinst() {
	# use standard -l options
	sed -i -e 's:-l[a-z0-9A-Z_/-]*/lib\([a-z]*\)\.so:-l\1:g' "${D}"/usr/*/pkgconfig/gammu.pc || die "sed failed"
}
