# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dynamips/dynamips-0.2.14.ebuild,v 1.1 2014/11/28 07:01:11 idella4 Exp $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="Cisco 7200/3600 Simulator"
HOMEPAGE="http://www.gns3.net/dynamips/"
SRC_URI="mirror://sourceforge/project/gns-3/Dynamips/${PV}/${P}-source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	dev-libs/elfutils
	net-libs/libpcap"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README RELEASE-NOTES )

S="${WORKDIR}"

src_prepare() {
	# patch CMakeLists to remove install_docs and use Portage instead
	epatch "${FILESDIR}"/${PV}-docs.patch

	# comment out DYNAMIPS_FLAGS to respect use set CFLAGS
	sed -e 's:^set ( DYNAMIPS_FLAGS:#&:' -i cmake/dependencies.cmake || die
}

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
