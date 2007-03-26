# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mkl/mkl-9.0.018.ebuild,v 1.2 2007/03/26 10:47:24 bicatali Exp $

inherit toolchain-funcs fortran

DESCRIPTION="Intel(R) Math Kernel Library: linear algebra, fft, random number generators."
HOMEPAGE="http://developer.intel.com/software/products/mkl/"
SRC_URI="l_${PN}_p_${PV}.tgz"
RESTRICT="nostrip fetch"

IUSE="fortran95 fftw examples"
SLOT="0"
LICENSE="mkl-9.0"
KEYWORDS="~x86 ~amd64 ~ia64"
RDEPEND="app-admin/eselect-blas
	app-admin/eselect-cblas
	app-admin/eselect-lapack"
DEPEND="${RDEPEND}"

PROVIDE="virtual/blas
	virtual/lapack"

pkg_nofetch() {
	einfo "Please download the intel mkl from:"
	einfo "http://www.intel.com/software/products/mkl/downloads/lin_mkl.htm"
	einfo "and place it in ${DISTDIR}"
	einfo "Also you need to register in ${HOMEPAGE}"
	einfo "and keep the license Intel sent you"
}

pkg_setup() {

	if  [[ -z "${INTEL_LICENSE}" ]] &&
		[[ -z "$(find /opt/intel/licenses -name *MKL*.lic)" ]]; then
		eerror "Did not find any valid mkl license."
		eerror "Please locate your license file and run:"
		eerror "\t INTEL_LICENSE=/my/license/dir emerge ${PN}"
		eerror "or place your license in /opt/intel/licenses"
		eerror "Hint: the license file is in the email Intel sent you"
		die
	fi

	# setting up compilers
	INTEL_CC=gnu
	[[ "$(tc-getCC)" ==  "icc" ]] && INTEL_CC=icc
	# gfortran still not compiling tests nor fortran95 interface
	FORTRAN="ifc g77"
	use fortran95 && FORTRAN="ifc"
	fortran_pkg_setup

	# setting up architecture name
	case ${ARCH} in
		x86) INTEL_ARCH="32" INTEL_KERN=ia32 ;;
		amd64) INTEL_ARCH="em64t" INTEL_KERN=em64t ;;
		ia64) INTEL_ARCH="64" INTEL_KERN=ipf ;;
	esac
}

src_unpack() {

	ewarn
	ewarn "Intel ${PN} requires 400Mb of disk space"
	ewarn "Make sure you have them on ${PORTAGE_TMPDIR} and in /opt/intel"
	ewarn
	unpack ${A}

	cd l_${PN}_p_${PV}/install

	# make an answer file to install non-interactivaly
	# (devs: to produce such a file, first do it interactively
	# tar xvf l_*; cd l_*/install; ./install --duplicate answers.txt)
	echo $"
[MKL]
EULA_ACCEPT_REJECT=ACCEPT
FLEXLM_LICENSE_LOCATION=${INTEL_LICENSE}
INSTALLMODE=NONRPM
INSTALL_DESTINATION=${S}
" > answers.txt

	einfo "Extracting ..."
	# the binary blob extractor forces installation in /opt/intel
	addwrite /opt/intel
	./install \
		--silent answers.txt \
		--log log.txt &> /dev/null

	[[ -z $(find "${WORKDIR}" -name libmkl.so) ]] \
		&& 	die "extracting failed"

	cd "${WORKDIR}" && rm -rf l_*
}

src_compile() {

	cd "${S}"/tools/builder
	for x in blas cblas lapack; do
		emake \
			export="${FILESDIR}"/${x}.list \
			name=lib${x} \
			${INTEL_KERN} || die "emake ${x} failed"
	done

	if use fortran95; then
		for x in blas95 lapack95; do
			cd "${S}"/interfaces/${x}
			emake -j1 \
				PLAT=lnx${INTEL_ARCH/em64t/32e} \
				FC=${FORTRANC} \
				INSTALL_DIR=../../lib/${INTEL_ARCH} \
				lib || die "emake ${x} failed"
		done
	fi

	if use fftw; then
		for x in "${S}"/interfaces/fft*; do
			cd "${x}"
			emake \
				F=${INTEL_CC} \
				lib${INTEL_ARCH} || die "emake ${x} failed"
		done
	fi
}

src_test() {
	# only testing with g77/gcc for now
	cd "${S}"/tests
	for testdir in * ; do
		einfo "Testing ${testdir}"
		cd ${testdir}
		emake \
			F=gnu \
			lib${INTEL_ARCH} || die "emake ${testdir} failed"
	done
}

src_install() {

	# install license in case of the extracting did not
	if  [ -n "${INTEL_LICENSE}" -a -f "${INTEL_LICENSE}" ]; then
		insinto /opt/intel/licenses
		doins "${INTEL_LICENSE}"
	fi

	local install_dir=/opt/intel/${PN}/${PV:0:3}
	dodir ${install_dir}
	cp -pPR include lib man doc "${D}"${install_dir}

	dodir /usr/$(get_libdir)/{blas,lapack}/mkl
	dosym ${install_dir}/lib/${INTEL_ARCH}/libmkl_${INTEL_KERN}.a \
		/usr/$(get_libdir)/blas/mkl/libblas.a
	dosym ${install_dir}/lib/${INTEL_ARCH}/libmkl_${INTEL_KERN}.a \
		/usr/$(get_libdir)/blas/mkl/libcblas.a
	dosym /${install_dir}/lib/${INTEL_ARCH}/libmkl_lapack.a \
		/usr/$(get_libdir)/lapack/mkl/liblapack.a

	insopts -m0755
	insinto /usr/$(get_libdir)/blas/mkl
	newins tools/builder/libblas.so libblas.so.0
	newins tools/builder/libcblas.so libcblas.so.0
	insinto /usr/$(get_libdir)/lapack/mkl
	newins tools/builder/liblapack.so liblapack.so.0

	dosym libblas.so.0  /usr/$(get_libdir)/blas/mkl/libblas.so
	dosym libcblas.so.0 /usr/$(get_libdir)/blas/mkl/libcblas.so
	dosym liblapack.so.0 /usr/$(get_libdir)/lapack/mkl/liblapack.so

	dodir /usr/include
	dosym ${install_dir}/include /usr/include/${PN}

	rm -f tools/builder/*.so
	for d in plugins builder support; do
		insinto ${install_dir}/tools
		doins -r tools/${d}
	done

	if use examples; then
		insinto ${install_dir}
		doins -r examples
	fi

	eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas mkl
	eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas mkl
	eselect lapack add $(get_libdir) ${FILESDIR}/eselect.lapack mkl

	echo "INCLUDE=${install_dir}/include"  > 35mkl
	echo "MANPATH=${install_dir}/man"  > 35mkl
	echo "LDPATH=${install_dir}/lib/${INTEL_ARCH}" >> 35mkl
	doenvd 35mkl
}

pkg_postinst() {
	if [[ -z "$(eselect blas show)" ]]; then
		eselect blas set mkl
	fi
	if [[ -z "$(eselect cblas show)" ]]; then
		eselect cblas set mkl
	fi
	if [[ -z "$(eselect lapack show)" ]]; then
		eselect lapack set mkl
	fi

	elog "To use MKL's BLAS features, you have to issue (as root):"
	elog "\n\teselect blas set mkl"
	elog "To use MKL's CBLAS features, you have to issue (as root):"
	elog "\n\teselect cblas set mkl"
	elog "To use MKL's LAPACK features, you have to issue (as root):"
	elog "\n\teselect lapack set mkl"
}
