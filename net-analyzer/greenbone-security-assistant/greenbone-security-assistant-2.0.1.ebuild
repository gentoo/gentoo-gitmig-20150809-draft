# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/greenbone-security-assistant/greenbone-security-assistant-2.0.1.ebuild,v 1.1 2011/10/09 17:29:41 hanno Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Greenbone Security Assistant for openvas"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/857/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-4
	dev-libs/libxslt
	net-libs/libmicrohttpd"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

# Workaround for upstream bug, it doesn't like out-of-tree builds.
CMAKE_BUILD_DIR="${S}"

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README || die "dodoc failed"
	doinitd "${FILESDIR}"/gsad || die
}
