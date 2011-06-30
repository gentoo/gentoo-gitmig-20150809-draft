# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgit2/libgit2-0.13.0.ebuild,v 1.1 2011/06/30 21:02:39 radhermit Exp $

EAPI=4

inherit cmake-utils multilib

DESCRIPTION="A linkable library for Git"
HOMEPAGE="http://libgit2.github.com/"
SRC_URI="https://github.com/downloads/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

DOCS=( README.md )
PATCHES=( "${FILESDIR}"/${P}-system-zlib.patch )

src_configure() {
	local mycmakeargs=(
		-DINSTALL_LIB=/usr/$(get_libdir)
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use examples ; then
		docinto examples
		dodoc examples/*
	fi
}
