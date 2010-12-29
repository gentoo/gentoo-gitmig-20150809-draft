# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cctbx/cctbx-2010.03.29.2334-r1.ebuild,v 1.3 2010/12/29 15:16:29 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils python toolchain-funcs

MY_PV="${PV//./_}"

DESCRIPTION="Computational Crystallography Toolbox"
HOMEPAGE="http://cctbx.sourceforge.net/"
SRC_URI="http://cci.lbl.gov/cctbx_build/results/${MY_PV}/${PN}_bundle.tar.gz -> ${P}.tar.gz"

LICENSE="cctbx-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+minimal openmp threads"

RDEPEND="
	>dev-libs/boost-1.39
	sci-libs/clipper
	sci-libs/fftw
	!minimal? (
		sci-chemistry/cns
		sci-chemistry/shelx )"
DEPEND="${RDEPEND}
	>=dev-util/scons-1.2"

S="${WORKDIR}"
MY_S="${WORKDIR}"/cctbx_sources
MY_B="${WORKDIR}"/cctbx_build

pkg_setup() {
	if use openmp && ! tc-has-openmp; then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 and icc"
		ewarn "If you want to build ${PN} with OpenMP, abort now,"
		ewarn "and switch CC to an OpenMP capable compiler"
	fi
	python_set_active_version 2
}

src_prepare() {
	local opts
	local optsld

	epatch "${FILESDIR}"/${PV}-tst_server.py.patch

	rm -rf "${MY_S}/scons"

	mkdir -p "${MY_S}"/scons/src/ "${MY_S}/boost"

	ln -sf "${EPREFIX}"/usr/$(get_libdir)/scons-* "${MY_S}"/scons/src/engine || die

	# Get CXXFLAGS in format suitable for substitition into SConscript
	for i in ${CXXFLAGS}; do
		opts="${opts} \"${i}\","
	done

	# Strip off the last comma
	opts=${opts%,}

	# Fix CXXFLAGS
	sed -i \
		-e "s:\"-O3\", \"-ffast-math\":${opts}:g" \
		${MY_S}/libtbx/SConscript

	# Get LDFLAGS in format suitable for substitition into SConscript
	for i in ${LDFLAGS}; do
		optsld="${optsld} \"${i}\","
	done

	optsld=${optsld%,}

	# Fix LDFLAGS which should be as-needed ready
	sed -i \
		-e "s:\"-shared\":\"-shared\", ${optsld}:g" \
		${MY_S}/libtbx/SConscript
}

src_configure() {
	local compiler
	local myconf

	myconf="${MY_S}/libtbx/configure.py"

	# Get compiler in the right way
	compiler=$(expr match "$(tc-getCC)" '.*\([a-z]cc\)')
	myconf="${myconf} --compiler=${compiler}"

	# Precompiling python scripts. It is done in upstreams install script.
	# Perhaps use python_mod_optimize, but as this script works we should stick to it.
	$(PYTHON -a) "${MY_S}/libtbx/command_line/py_compile_all.py"

	# Additional USE flag usage
	check_use openmp
	myconf="${myconf} --enable-openmp-if-possible=${USE_openmp}"

	use threads && USEthreads="--enable-boost-threads" && \
		ewarn "If using boost threads openmp support is disabled"

	myconf="${myconf} ${USE_threads} --scan-boost"

	mkdir "${MY_B}" && myconf="${myconf} --current_working_directory=${MY_B}"
	cd "${MY_B}"

	myconf="${myconf} --build=release fftw3tbx rstbx smtbx mmtbx clipper fable"
	einfo "configuring with ${python} ${myconf}"

	$(PYTHON -a) ${myconf} \
		|| die "configure failed"
}

src_compile() {
	local makeopts_exp

	cd "${MY_B}"

	makeopts_exp=${MAKEOPTS/j/j }
	makeopts_exp=${makeopts_exp%-l[0-9]*}

	source setpaths_all.sh

	einfo "compiling with libtbx.scons ${makeopts_exp}"
	libtbx.scons ${makeopts_exp} .|| die "make failed"
}

src_test(){
	source "${MY_B}"/setpaths_all.sh
	libtbx.python $(libtbx.show_dist_paths boost_adaptbx)/tests/tst_rational.py && \
	libtbx.python ${SCITBX_DIST}/run_tests.py ${MAKEOPTS_EXP} && \
	libtbx.python ${CCTBX_DIST}/run_tests.py  ${MAKEOPTS_EXP} \
	|| die "test failed"
}

src_install(){
	# This is what Bill Scott does in the fink package. Do we need this as well?
#	-e "s:prepend:append:g" \

	find cctbx_build/ -type f \( -name "*.py" -o -name "*sh" \) -exec \
	sed -e "s:${MY_S}:${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_sources:g" \
	    -e "s:${MY_B}:${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_build:g"  \
	    -i '{}' \; || die "Fail to correct path"

	ebegin "removing unnessary files"
		rm -r "${S}"/cctbx_sources/{boost,scons} || die "failed to remove uneeded scons"
		find "${S}" -type f -name "*conftest*" -delete || die "failed to remove uneeded *.o"
		find "${S}" -type f -name "*.o" -delete || die "failed to remove uneeded *.o"
		find "${S}" -type f -name "*.c" -delete || die "failed to remove uneeded *.c"
		find "${S}" -type f -name "*.f" -delete || die "failed to remove uneeded *.c"
		find "${S}" -type f -name "*.cpp" -delete || die "failed to remove uneeded *.cpp"
		find "${S}" -type f -name "*.pyc" -delete || die "failed to remove uneeded *.pyc"
		find "${S}" -type d -empty -delete || die
	eend

	insinto /usr/$(get_libdir)/${PN}
	doins -r cctbx_sources cctbx_build || die

# fperms cannot handle wildcards
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/*sh && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/lib/* && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/scitbx/array_family/* && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/scitbx/serialization/* && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/scitbx/error/* && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/scitbx/fftpack/timing/* && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/scitbx/lbfgs/* && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/chiltbx/handle_test && \
	chmod 775 "${ED}"/usr/$(get_libdir)/${PN}/cctbx_build/bin/* || \
	die

	insinto /etc/profile.d/
	newins "${MY_B}"/setpaths.sh 30cctbx.sh || die
	newins "${MY_B}"/setpaths.csh 30cctbx.csh || die

	cat >> "${T}"/30cctbx <<- EOF
	LDPATH="${EPREFIX}/usr/$(get_libdir)/${PN}/cctbx_build/lib"
	EOF

	doenvd "${T}"/30cctbx || die
}

pkg_postinst () {
	python_need_rebuild
	python_mod_optimize /usr/$(get_libdir)/${PN}/cctbx_sources
}

pkg_postrm () {
	python_mod_cleanup /usr/$(get_libdir)/${PN}/cctbx_sources
}

check_use() {
	for var in $@; do
		if use ${var}; then
			printf -v "USE_$var" True
		else
			printf -v "USE_$var" False
		fi
	shift
	done
}
