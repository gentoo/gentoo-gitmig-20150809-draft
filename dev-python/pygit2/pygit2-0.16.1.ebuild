# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygit2/pygit2-0.16.1.ebuild,v 1.1 2012/03/31 22:28:15 radhermit Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Python bindings for libgit2"
HOMEPAGE="https://github.com/libgit2/pygit2"
SRC_URI="https://github.com/libgit2/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-libs/libgit2-0.16*
	dev-libs/openssl
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}
