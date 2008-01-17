# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-4.0.0.ebuild,v 1.1 2008/01/17 23:56:29 philantrop Exp $

EAPI="1"
inherit kde4-base

DESCRIPTION="KDE utilities."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug archive crypt htmlhandbook python tpctl xscreensaver zip"
LICENSE="GPL-2 LGPL-2"

COMMON_DEPEND=">=kde-base/kdebase-${PV}:${SLOT}
	dev-libs/gmp
	tpctl? ( app-laptop/tpctl )
	python? ( dev-lang/python )
	archive? ( app-arch/libarchive )
	zip? ( >=dev-libs/libzip-0.8 )
	x11-libs/libXtst"
RDEPEND="${COMMON_DEPEND}
	crypt? ( app-crypt/gnupg )
	virtual/ssh"
DEPEND="${COMMON_DEPEND}
	kernel_linux? ( virtual/os-headers )
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libX11
	x11-proto/xproto"

src_compile() {
	# Disabling xmms support: not in portage.
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with tpctl TPCTL)
		$(cmake-utils_use_with python PythonLibs)
		$(cmake-utils_use_with zip LibZip)"

	kde4-base_src_configure

	# Ok, this is a really ugly hack but it's needed if superkaramba is built
	# with Python because src_compile would fail with undefined symbols from
	# libdl and libutil. If you bump this, please try commenting this out.
#	sed -i -e "s:-Wl,-rpath:-ldl -lutil -Wl,-rpath:" \
#		./superkaramba/src/CMakeFiles/superkaramba.dir/link.txt || die "Python hack failed."

	kde4-base_src_make
}

src_test() {
	pushd "${WORKDIR}"/${PN}_build/kcalc/knumber/tests > /dev/null
	emake knumbertest && \
		./knumbertest.shell || die "Tests failed."
	popd > /dev/null
}
