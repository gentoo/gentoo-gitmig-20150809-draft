# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gflags/gflags-0.8.ebuild,v 1.1 2008/06/16 19:37:28 dev-zero Exp $

inherit distutils

DESCRIPTION="Google's C++ argument parsing library with python extensions."
HOMEPAGE="http://code.google.com/p/google-gflags/"
SRC_URI="http://google-gflags.googlecode.com/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"

DEPEND="python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use python;
	then
		cd python
		distutils_src_compile
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use python;
	then
		cd python
		distutils_src_install
	fi
}
