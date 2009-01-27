# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/soprano/soprano-2.0.2.ebuild,v 1.4 2009/01/27 00:32:27 vapier Exp $

EAPI="1"
inherit cmake-utils eutils flag-o-matic

DESCRIPTION="library which provides a nice QT interface to RDF storage solutions"
HOMEPAGE="http://nepomuk-kde.semanticdesktop.org/xwiki/bin/view/Main/Soprano"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+clucene debug doc elibc_FreeBSD"
RESTRICT="test"

COMMON_DEPEND="
	>=dev-libs/redland-1.0.6
	>=dev-libs/rasqal-0.9.15
	>=media-libs/raptor-1.4.16
	|| ( ( x11-libs/qt-core:4
		x11-libs/qt-dbus:4 )
		=x11-libs/qt-4.3*:4 )
	clucene? ( >=dev-cpp/clucene-0.9.19 )"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}"

pkg_setup() {
	if has_version "<x11-libs/qt-4.4.0_alpha:4" && \
		! built_with_use x11-libs/qt:4 dbus; then
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

	# Disable the optional Sesame storage backend until sesame is in portage.
	sed -e '/find_package(JNI)/s/^/#DONOTFIND /' \
		-i "${S}/CMakeLists.txt" || die "Sed for Java JNI automagic dependency failed."

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
