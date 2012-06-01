# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xdelta/xdelta-3.0.0-r1.ebuild,v 1.2 2012/06/01 13:03:22 ago Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"

inherit distutils toolchain-funcs eutils

DESCRIPTION="a binary diff and differential compression tools. VCDIFF (RFC 3284) delta compression."
HOMEPAGE="http://xdelta.org"
SRC_URI="http://${PN}.googlecode.com/files/${P/-}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

DEPEND="test? ( app-arch/ncompress )"
RDEPEND=""

S="${WORKDIR}/${P/-}"

DOCS="draft-korn-vcdiff.txt"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e 's:-O3:-Wall:' setup.py || die "setup.py sed failed"
	sed \
		-e 's:-O3::g' \
		-e 's:$(CC):$(CC) $(LDFLAGS):g' \
		-e 's:CFLAGS=:CFLAGS+=:' \
		-i Makefile || die "Makefile sed failed"

	EPATCH_SOURCE="${FILESDIR}" epatch \
		01_bigger_print_buffers.patch \
		02_replace_sprintf_with_snprintf.patch \
		03_fix_pipe_draining_and_closing.patch
}

src_test() {
	if [ $UID != 0 ]; then
		emake test
	else
		ewarn "Tests can't be run as root, skipping."
	fi
}

src_compile() {
	tc-export CC CXX
	distutils_src_compile
	emake xdelta3
	if use test; then
		emake xdelta3-debug
	fi
}

src_install() {
	dobin xdelta3
	distutils_src_install
}
