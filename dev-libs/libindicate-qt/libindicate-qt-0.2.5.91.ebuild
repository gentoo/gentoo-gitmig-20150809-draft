# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate-qt/libindicate-qt-0.2.5.91.ebuild,v 1.3 2012/07/27 16:19:24 ssuominen Exp $

EAPI=4
inherit eutils virtualx cmake-utils

_UBUNTU_REVISION=5

DESCRIPTION="Qt wrapper for libindicate library"
HOMEPAGE="https://launchpad.net/libindicate-qt/"
SRC_URI="mirror://ubuntu/pool/main/libi/${PN}/${PN}_${PV}.orig.tar.bz2
	mirror://ubuntu/pool/main/libi/${PN}/${PN}_${PV}-${_UBUNTU_REVISION}.debian.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libindicate-12.10.0
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_test() {
	local ctestargs
	[[ -n ${TEST_VERBOSE} ]] && ctestargs="--extra-verbose --output-on-failure"

	cd "${CMAKE_BUILD_DIR}"/tests

	VIRTUALX_COMMAND="ctest ${ctestargs}" virtualmake || die
}

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX=diff epatch "${WORKDIR}"/debian/patches
}
