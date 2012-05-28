# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcxxrt/libcxxrt-0.0_p20120528.ebuild,v 1.1 2012/05/28 13:58:04 aballier Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/pathscale/libcxxrt.git"

[ "${PV%9999}" != "${PV}" ] && SCM="git-2" || SCM=""

inherit cmake-utils ${SCM} base flag-o-matic

DESCRIPTION="C++ Runtime from PathScale, FreeBSD and NetBSD."
HOMEPAGE="https://github.com/pathscale/libcxxrt http://www.pathscale.com/node/265"
if [ "${PV%9999}" = "${PV}" ] ; then
	SRC_URI="mirror://gentoo/${P}.tar.xz"
	DEPEND="app-arch/xz-utils"
else
	SRC_URI=""
fi

LICENSE="BSD-2"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64"
else
	KEYWORDS=""
fi
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	${DEPEND}"

PATCHES=( "${FILESDIR}/0001-Link-to-libdl-where-needed-for-dladdr-exception.cc.patch" )

src_prepare() {
	base_src_prepare
}

src_install() {
	# TODO: See README. Maybe hide it in a subdir and let only libcxx know about
	# it. FreeBSD head installs it in /lib
	cd "${CMAKE_BUILD_DIR}"
	dolib.so lib/${PN}.so
	dolib.a lib/${PN}.a

	cd "${S}"

	insinto /usr/include/libcxxrt/
	doins src/cxxabi.h src/unwind*.h

	dodoc AUTHORS COPYRIGHT README
}
