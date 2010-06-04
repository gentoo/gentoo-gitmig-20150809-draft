# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/camfr/camfr-20070717-r1.ebuild,v 1.6 2010/06/04 16:34:26 arfrever Exp $

EAPI=2
inherit eutils distutils python toolchain-funcs

DESCRIPTION="Full vectorial Maxwell solver based on eigenmode expansion"
HOMEPAGE="http://camfr.sourceforge.net/"
SRC_URI="mirror://sourceforge/camfr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-libs/scipy
	dev-lang/python[tk]
	dev-python/imaging[tk]
	dev-python/matplotlib
	dev-libs/boost[python]
	dev-libs/blitz
	virtual/lapack"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/scons-0.98"

S="${WORKDIR}/${P/-/_}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	cp "${FILESDIR}"/machine_cfg.py.gentoo machine_cfg.py || die

	# Configure to compile against selected python version
	cat <<-EOF >> machine_cfg.py
		include_dirs = []
		include_dirs.append("$(python_get_includedir)")
		include_dirs.append("$(python_get_sitedir)")
	EOF

	local lapack_libs=
	for x in $(pkg-config --libs-only-l lapack); do
		lapack_libs="${lapack_libs}, \"${x#-l}\""
	done
	local lapack_libdirs=
	for x in $(pkg-config --libs-only-L lapack); do
		lapack_libdirs="${lapack_libdirs}, \"${x#-L}\""
	done
	local libfort
	case "$(tc-getF77)" in
		*gfortran) libfort=gfortran ;;
		*g77) libfort=g2c ;;
	esac
	cat <<-EOF >> machine_cfg.py
		library_dirs = [${lapack_libdirs#,}]
		libs = ["boost_python", "${libfort}", "blitz"${lapack_libs}]
	EOF
	export F77=$(tc-getF77)
}

src_test() {
	# trick to avoid X in testing (bug #229753)
	echo "backend : Agg" > matplotlibrc
	PYTHONPATH=".:visualisation" "$(PYTHON)" testsuite/camfr_test.py \
		|| die "tests failed"
	rm -f matplotlibrc
}

src_install() {
	python_need_rebuild
	distutils_src_install
	dodoc docs/camfr.pdf || die "doc install failed"
}
