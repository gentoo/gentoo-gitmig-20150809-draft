# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cctbx/cctbx-2010.03.29.2334-r2.ebuild,v 1.3 2010/12/29 15:16:29 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils python toolchain-funcs

MY_PV="${PV//./_}"

DESCRIPTION="Computational Crystallography Toolbox"
HOMEPAGE="http://cctbx.sourceforge.net/"
SRC_URI="http://cci.lbl.gov/cctbx_build/results/${MY_PV}/${PN}_bundle.tar.gz -> ${P}.tar.gz"

LICENSE="cctbx-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
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
	epatch "${FILESDIR}"/${PV}-boost.patch
	epatch "${FILESDIR}"/${PV}-clipper.patch
	epatch "${FILESDIR}"/${PV}-flags.patch
	epatch "${FILESDIR}"/${PV}-soname.patch

	rm -rf "${MY_S}/scons" "${MY_S}/boost" "${MY_S}/PyCifRW"
	find "${MY_S}/clipper" -name "*.h" -delete

	echo "import os, sys; os.execvp('scons', sys.argv)" > "${MY_S}"/libtbx/command_line/scons.py
}

src_configure() {
	local compiler
	local myconf

	myconf="${MY_S}/libtbx/configure.py"

	compiler=$(expr match "$(tc-getCC)" '.*\([a-z]cc\)')
	myconf="${myconf} --compiler=${compiler}"

	# Additional USE flag usage
	check_use openmp
	myconf="${myconf} --enable-openmp-if-possible=${USE_openmp}"

	use threads && USEthreads="--enable-boost-threads" && \
		ewarn "If using boost threads openmp support is disabled"

	myconf="${myconf} ${USE_threads} --scan-boost --use_environment_flags"

	mkdir "${MY_B}" && myconf="${myconf} --current_working_directory=${MY_B}"
	cd "${MY_B}"

	myconf="${myconf} --build=release fftw3tbx rstbx smtbx mmtbx clipper_adaptbx fable"
	einfo "configuring with ${python} ${myconf}"

	$(PYTHON) ${myconf} || die "configure failed"
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
#	find cctbx_build/ -type f \( -name "*.py" -o -name "*sh" \) -exec \
#	sed -e "s:${MY_S}:${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_sources:g" \
#	    -e "s:${MY_B}:${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_build:g"  \
#	    -i '{}' \; || die "Fail to correct path"

	ebegin "removing unnessary files"
		rm -r "${S}"/cctbx_sources/{clipper,ccp4io,ucs-fonts,TAG} || die "failed to remove uneeded scons"
		find "${S}" -type f -name "*conftest*" -delete || die "failed to remove uneeded *.o"
		find "${S}" -type f -name "*.o" -delete || die "failed to remove uneeded *.o"
		find "${S}" -type f -name "*.c" -delete || die "failed to remove uneeded *.c"
		find "${S}" -type f -name "*.f" -delete || die "failed to remove uneeded *.c"
		find "${S}" -type f -name "*.cpp" -delete || die "failed to remove uneeded *.cpp"
		find "${S}" -type f -name "*.pyc" -delete || die "failed to remove uneeded *.pyc"
		find "${S}" -type f -name "SCons*" -delete || die "failed to remove uneeded *.pyc"
		find "${S}" -type f -name "Makefile" -delete || die "failed to remove uneeded *.pyc"
		find "${S}" -type f -name "config.log" -delete || die "failed to remove uneeded *.pyc"
		find "${S}" -type d -empty -delete || die
		find ${MY_B} -maxdepth 1 -type f
		find ${MY_B} -maxdepth 1 -type f -delete
	eend

	dobin ${MY_B}/bin/* || die
	rm -rf ${MY_B}/bin
	dolib.so ${MY_B}/lib/lib* || die
	rm -f ${MY_B}/lib/lib*

	insinto /usr/include
	doins -r ${MY_B}/include/* || die
	rm -rf ${MY_B}/include

	insinto /usr/libexec/${PN}
	doins -r ${MY_B}/* || die
	find "${ED}"/usr/libexec/${PN} -type f -exec chmod 755 '{}' \;

	cd ${MY_S}
	insinto $(python_get_sitedir)
	doins -r * || die
	exeinto $(python_get_sitedir)
	doexe ${MY_B}/lib/* || die
	rm -rvf ${MY_B}/lib

	sed \
		-e "/PYTHONPATH/s:${MY_S}:$(python_get_sitedir):g" \
		-e "/PYTHONPATH/s:${MY_B}:$(python_get_sitedir):g" \
		-e "/LD_LIBRARY_PATH/s:${MY_B}/lib:${EPREFIX}/usr/$(get_libdir):g" \
		-e "/PATH/s:${MY_B}/bin:${EPREFIX}/usr/bin:g" \
		-e "/PATH/s:${MY_B}/exe:${EPREFIX}/usr/bin:g" \
		-e "/exec/s:${MY_S}:$(python_get_sitedir):g" \
		-e "/LIBTBX_BUILD/s:${MY_B}:/usr:g" \
		-i "${ED}"/usr/bin/* || die

}

pkg_postinst () {
	python_need_rebuild
	python_mod_optimize boost_adaptbx cbflib_adaptbx ccp4io_adaptbx cctbx chiltbx clipper_adaptbx crys3d fable fftw3tbx gltbx iotbx libtbx mmtbx omptbx rstbx scitbx smtbx spotfinder tntbx
}

pkg_postrm () {
	python_mod_cleanup boost_adaptbx cbflib_adaptbx ccp4io_adaptbx cctbx chiltbx clipper_adaptbx crys3d fable fftw3tbx gltbx iotbx libtbx mmtbx omptbx rstbx scitbx smtbx spotfinder tntbx
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
