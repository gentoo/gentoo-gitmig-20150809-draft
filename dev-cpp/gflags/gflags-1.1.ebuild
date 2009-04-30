# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gflags/gflags-1.1.ebuild,v 1.1 2009/04/30 08:04:15 dev-zero Exp $

EAPI="2"

inherit python

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
	default

	if use python; then
		cd python
		python_version
		"${python}" setup.py build || die "python build failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -rf "${D}"/usr/share/doc/*
	AUTHORS ChangeLog NEWS README
	dohtml doc/*

	if use python; then
		cd python
		python_version
		"${python}" setup.py install --root="${D}" --no-compile || die "python install failed"
		python_need_rebuild
	fi
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
