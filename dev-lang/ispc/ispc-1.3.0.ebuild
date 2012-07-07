# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ispc/ispc-1.3.0.ebuild,v 1.1 2012/07/07 00:48:30 ottxor Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Intel SPMD Program Compiler"
HOMEPAGE="http://ispc.github.com/"

if [[ ${PV} = *9999 ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/ispc/ispc.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/ispc/ispc/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
	GITHUB_ID="c6ec130"
	S="${WORKDIR}/${PN}-${PN}-${GITHUB_ID}"
fi

LICENSE="BSD BSD-2 UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="
	>=sys-devel/clang-3.0
	>=sys-devel/llvm-3.0
	"
DEPEND="
	${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	"

DOCS=( README.rst )

src_compile() {
	emake LDFLAGS="${LDFLAGS}" OPT="${CXXFLAGS}" CXX="$(tc-getCXX)" CPP="$(tc-getCPP)"
}

src_install() {
	dobin ispc

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		docompress -x "/usr/share/doc/${PF}/examples"
		doins -r examples/*
	fi
}
