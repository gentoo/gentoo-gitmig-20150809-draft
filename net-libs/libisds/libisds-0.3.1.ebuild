# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libisds/libisds-0.3.1.ebuild,v 1.1 2010/06/29 14:03:45 scarabeus Exp $

EAPI=3

[[ ${PV} = 9999* ]] && GIT="git"
EGIT_REPO_URI="git://repo.or.cz/${PN}.git"
inherit base autotools ${GIT}

DESCRIPTION="Client library to access ISDS Soap service"
HOMEPAGE="http://www.abclinuxu.cz/datove-schranky/libisds"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi
LICENSE="LGPL-2"

SLOT="0"
IUSE="debug test"

RDEPEND="
	dev-libs/expat
	dev-libs/libgcrypt
	dev-libs/libxml2
	net-misc/curl[ssl]
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		--disable-fatalwarnings \
		$(use_enable test) \
		$(use_enable debug)

}
