# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libisds/libisds-9999.ebuild,v 1.7 2011/03/03 15:20:02 scarabeus Exp $

EAPI=3

[[ ${PV} = 9999* ]] && GIT="git autotools"
EGIT_REPO_URI="git://repo.or.cz/${PN}.git"
inherit autotools-utils ${GIT}

DESCRIPTION="Client library for accessing ISDS Soap services"
HOMEPAGE="http://xpisar.wz.cz/libisds/"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://xpisar.wz.cz/${PN}/dist/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="debug nls static-libs test"

COMMON_DEPEND="
	app-crypt/gpgme
	dev-libs/expat
	dev-libs/libgcrypt
	dev-libs/libxml2
	net-misc/curl[ssl]
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
"
RDEPEND="${COMMON_DEPEND}
	>=app-crypt/gnupg-2
"

DOCS=( "NEWS" "README" "AUTHORS" "ChangeLog" )

src_prepare() {
	autotools-utils_src_prepare
	[[ ${PV} = 9999* ]] && eautoreconf
}

src_configure() {
	local myeconfargs=(
		"--disable-fatalwarnings"
		$(use_enable debug)
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_enable test)
	)

	autotools-utils_src_configure
}
