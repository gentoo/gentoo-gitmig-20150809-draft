# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebkitgtk/pywebkitgtk-1.1.8-r1.ebuild,v 1.2 2013/06/23 15:08:57 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1

DESCRIPTION="Python bindings for the WebKit GTK+ port"
HOMEPAGE="http://code.google.com/p/pywebkitgtk/"
SRC_URI="http://pywebkitgtk.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-libs/libxslt[${PYTHON_USEDEP}]
	>=net-libs/webkit-gtk-1.1.15:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS MAINTAINERS NEWS README )
RESTRICT="test"

src_prepare() {
	python_copy_sources
}

src_configure() {
	config() {
		econf --disable-static
	}
#ECONF_SOURCE="{S}" econf --disable-static
	python_parallel_foreach_impl run_in_build_dir config
}

src_compile() {
	python_foreach_impl run_in_build_dir emake
}

# Need fix a dbus session issue run as root
src_test() {
	testing() {
		local test
		pushd webkit > /dev/null
		ln -sf ../webkit.la . || die
		ln -sf ../.libs/webkit.so . || die
		popd > /dev/null
		for test in tests/test_*.py
		do
			if ! PYTHONPATH=. "${PYTHON}" ${test}; then
				die "Test ${test} failed under ${EPYTHON}"
			fi
		done
		einfo "Testsuite passed under ${EPYTHON}"
		# rm symlinks
		rm -f webkit/{webkit.la,webkit.so}
	}
	python_foreach_impl run_in_build_dir testing
}

src_install() {
	python_foreach_impl run_in_build_dir default
}
