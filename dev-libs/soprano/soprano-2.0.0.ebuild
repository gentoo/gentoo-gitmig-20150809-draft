# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/soprano/soprano-2.0.0.ebuild,v 1.1 2008/01/13 19:05:26 philantrop Exp $

EAPI="1"
inherit cmake-utils eutils flag-o-matic

DESCRIPTION="Soprano is a library which provides a nice QT interface to RDF storage solutions."
HOMEPAGE="http://nepomuk-kde.semanticdesktop.org/xwiki/bin/view/Main/Soprano"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+clucene debug doc elibc_FreeBSD"
RESTRICT="test"

DEPEND="
	>=dev-libs/redland-1.0.6
	>=media-libs/raptor-1.4.16
	>=x11-libs/qt-4.2.0:4
	clucene? ( >=dev-cpp/clucene-0.9.19 )
	doc? ( app-doc/doxygen )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use x11-libs/qt:4 dbus; then
		eerror "To install ${PN} you need to build Qt with dbus support."
		die "x11-libs/qt:4 NOT built with USE=\"dbus\"."
	fi
}

src_compile() {
	# Fix automagic dependencies / linking
	if ! use clucene; then
		sed -e '/find_package(CLucene)/s/^/#DONOTFIND /' \
			-i "${S}/CMakeLists.txt" || die "Sed for CLucene automagic dependency failed."
	fi

	if ! use doc; then
		sed -e '/find_package(Doxygen)/s/^/#DONOTFIND /' \
			-i "${S}/CMakeLists.txt" || die "Sed to disable api-docs failed."
	fi

	sed -e '/add_subdirectory(test)/s/^/#NOTESTS /' \
		-e '/enable_testing/s/^/#NOTESTS /' \
		-i "${S}"/CMakeLists.txt || die "Disabling tests failed."

	# Fix for missing pthread.h linking
	# NOTE: temporarely fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-ldflags "-lpthread"

	cmake-utils_src_compile
}

src_test() {
	sed -e 's/#NOTESTS//' \
		-i "${S}"/CMakeLists.txt || die "Enabling tests failed."
	cmake-utils_src_compile
	ctest --extra-verbose || die "Tests failed."
}
