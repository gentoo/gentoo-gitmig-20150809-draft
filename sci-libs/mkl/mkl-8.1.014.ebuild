# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mkl/mkl-8.1.014.ebuild,v 1.2 2007/03/24 23:11:42 bicatali Exp $

inherit fortran rpm flag-o-matic

MYPV=${PV%.*}
DESCRIPTION="Intel(R) Math Kernel Library: linear algebra, fft, random number generators."
HOMEPAGE="http://developer.intel.com/software/products/mkl/"
SRC_URI="l_${PN}_p_${PV}.tgz"
RESTRICT="nostrip fetch"

#fortran95 implements a fortran 95 blas/lapack interface
IUSE="fortran95 examples"
SLOT="0"
LICENSE="mkl-8.0.1"
KEYWORDS="~x86 ~amd64 ~ia64"
RDEPEND="virtual/libc
	app-admin/eselect-blas
	app-admin/eselect-cblas
	app-admin/eselect-lapack"
DEPEND="${RDEPEND}"
PROVIDE="virtual/blas
	virtual/lapack"


S="${WORKDIR}/l_${PN}_p_${PV}"
INSTDIR=opt/intel/${PN}/${MYPV}


pkg_setup() {

	if use fortran95; then
		FORTRAN="ifc gfortran"
		fortran_pkg_setup
	fi

	if  [ -z "${INTEL_LICENSE}" -a  -z \
		$(find /opt/intel/licenses -name *mkl*.lic) ]; then
		eerror "Did not find any valid mkl license."
		eerror "Please locate your license file and run:"
		eerror "\t INTEL_LICENSE=/my/license/files emerge ${PN}"
		eerror "or place your license in /opt/intel/licenses and run emerge ${PN}"
		elog
		elog "http://www.intel.com/cd/software/products/asmo-na/eng/perflib/mkl/219859.htm"
		elog "From the above url you can get a free, non-commercial"
		elog "license to use the Intel Math Kernel Libary emailed to you."
		elog "You cannot use mkl without this license file."
		elog "Read the website for more information on this license."
		elog
	fi
}


# the whole shmol is to extract rpm files non-interactively
# from the big mkl installation
# hopefully recyclable for ipp
src_unpack() {

	ewarn
	ewarn "Intel ${PN} requires 200Mb of disk space"
	ewarn "Make sure you have enough space on /var and also in /opt/intel"
	ewarn

	unpack ${A}

	# fake rpm commands to trick the big install script
	mkdir -p bin
	echo "exit 1" > bin/rpm2cpio
	echo "exit 1" > bin/rpm
	chmod +x bin/*
	PATH=".:${PATH}:$PWD/bin"

	cd ${S}/install
	# answer file to make the big install script non-interactive
	echo $"
[${PN}_install]
EULA_ACCEPT_REJECT=accept
FLEXLM_LICENSE_LOCATION=${INTEL_LICENSE}
TEMP_DIR=${WORKDIR}/rpm
INSTALL_DESTINATION=${S}
RPM_INSTALLATION=
" > answers.txt

	einfo "Building rpm file..."
	./install \
		--noroot \
		--nonrpm \
		--installpath ${S} \
		--silent answers.txt &> /dev/null

	[ -z $(find ${WORKDIR} -name "*.rpm") ] \
		&&	die "error while extracting the rpm"

	rm -rf ${WORKDIR}/bin ${S}/*

	cd ${S}
	for x in $(ls ../rpm/*.rpm); do
		einfo "Extracting $(basename ${x})..."
		rpm_unpack ${x} || die "rpm_unpack failed"
	done

	# clean up
	rm -rf ${WORKDIR}/rpm
	rm -rf ${S}/${INSTDIR}/tools/environment
}

src_compile() {

	case ${ARCH} in
		amd64)
			IARCH="em64t"
			IKERN="em64t"
			;;
		ia64)
			IARCH="64"
			IKERN="ipf"
			;;
		x86)
			IARCH="32"
			IKERN="ia32"
			;;
	esac
	ILIBDIR=${INSTDIR}/lib/${IARCH}
	einfo "IARCH=$IARCH IKERN=$IKERN"

	cd ${S}/${INSTDIR}/tools/builder
	for x in blas cblas lapack; do
		make ${IKERN} export=${FILESDIR}/${x}.list name=lib${x} \
			|| die "make ${IKERN} failed"
	done

	if use fortran95; then
		local fc=${FORTRANC}
		if [ "${FORTRANC}" = "ifc" ]; then
			fc=ifort
		fi
		for x in blas lapack; do
			cd ${S}/${INSTDIR}/interfaces/${x}95
			make lib \
				PLAT=lnx${IARCH/em64t/32e} \
				FC=${fc} \
				INSTALL_DIR=${S}/${ILIBDIR} || die "make lib failed"
		done
	fi
}

src_test() {
	local fc="gnu"
	[ "${FORTRANC}" = "ifc" ] && fc="ifort"

	cd ${S}/${INSTDIR}/tests
	for testdir in *; do
		einfo "Testing $testdir"
		cd ${testdir}
		emake so$IARCH F=${fc} || die "make $testdir failed"
	done
}

src_install () {
	cd ${S}

	# install license
	if  [ -n "${INTEL_LICENSE}" -a -f "${INTEL_LICENSE}" ]; then
		insinto /opt/intel/licenses
		doins ${INTEL_LICENSE}
	fi

	# install documentation and include files
	insinto /${INSTDIR}
	doins -r ${INSTDIR}/{doc,include}
	dodir /usr/include
	dosym /${INSTDIR}/include /usr/include/${PN}
	use examples && doins -r ${INSTDIR}/examples

	# install static libraries
	insinto /${ILIBDIR}
	doins ${ILIBDIR}/*.a
	dodir /usr/$(get_libdir)/{blas,lapack}/mkl
	dosym /${ILIBDIR}/libmkl_${IKERN}.a \
		/usr/$(get_libdir)/blas/mkl/libblas.a
	dosym /${ILIBDIR}/libmkl_lapack.a \
		/usr/$(get_libdir)/lapack/mkl/liblapack.a

	# install shared libraries
	insopts -m0755
	doins ${ILIBDIR}/*.so
	insinto /usr/$(get_libdir)/blas/mkl
	newins ${INSTDIR}/tools/builder/libblas.so libblas.so.0
	newins ${INSTDIR}/tools/builder/libcblas.so libcblas.so.0
	insinto /usr/$(get_libdir)/lapack/mkl
	newins ${INSTDIR}/tools/builder/liblapack.so liblapack.so.0
	dosym libblas.so.0  /usr/$(get_libdir)/blas/mkl/libblas.so
	dosym libcblas.so.0 /usr/$(get_libdir)/blas/mkl/libcblas.so
	dosym liblapack.so.0 /usr/$(get_libdir)/lapack/mkl/liblapack.so


	# install tools
	insopts -m0644
	insinto /${INSTDIR}
	rm -f ${INSTDIR}/tools/builder/*.so
	doins -r ${INSTDIR}/tools

	# install eselect files
	eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas mkl
	eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas mkl
	eselect lapack add $(get_libdir) ${FILESDIR}/eselect.lapack mkl

	# install environment var
	echo "LD_LIBRARY_PATH=/${ILIBDIR}" > 35mkl
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
