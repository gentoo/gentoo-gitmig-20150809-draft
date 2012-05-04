# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate-qt/libindicate-qt-0.2.5.91.ebuild,v 1.2 2012/05/04 13:14:11 johu Exp $

EAPI=4
inherit eutils virtualx cmake-utils

__ubuntu_revision=1ubuntu2

DESCRIPTION="Qt wrapper for libindicate library"
HOMEPAGE="https://launchpad.net/libindicate-qt/"
SRC_URI="mirror://ubuntu/pool/main/libi/${PN}/${PN}_${PV}.orig.tar.bz2
	mirror://ubuntu/pool/main/libi/${PN}/${PN}_${PV}-${__ubuntu_revision}.debian.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libindicate-0.6
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_test() {
	local ctestargs
	[[ -n ${TEST_VERBOSE} ]] && ctestargs="--extra-verbose --output-on-failure"

	cd "${CMAKE_BUILD_DIR}/tests"

	VIRTUALX_COMMAND="ctest ${ctestargs}" virtualmake || die "Tests failed."
}

src_prepare() {
	EPATCH_FORCE="yes" EPATCH_SUFFIX="diff" epatch "${WORKDIR}"/debian/patches
}
