# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gflags/gflags-0.7.ebuild,v 1.1 2008/03/09 07:40:02 antarus Exp $

inherit distutils

DESCRIPTION="Google's C++ argument parsing library with python extensions."
HOMEPAGE="http://code.google.com/p/google-gflags/"
SRC_URI="ftp://foo.bar.com/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use python;
	then
		cd python
		distutils_src_install
	fi
}
