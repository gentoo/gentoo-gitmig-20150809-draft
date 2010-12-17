# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mkl/mkl-9.1.023.ebuild,v 1.12 2010/12/17 13:41:58 jlec Exp $

inherit eutils versionator toolchain-funcs

PID=779
PB=${PN}
DESCRIPTION="Intel(R) Math Kernel Library: linear algebra, fft, random number generators."
HOMEPAGE="http://developer.intel.com/software/products/mkl/"

KEYWORDS="~x86 ~amd64 ~ia64"
SRC_URI="!int64? ( !serial? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/l_${PN}_p_${PV}.tgz ) )
	int64?  ( http://registrationcenter-download.intel.com/irc_nas/${PID}/l_${PN}_enh_p_${PV}.tgz )
	serial? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/l_${PN}_enh_p_${PV}.tgz )"

MAJOR=$(get_major_version ${PV})
MINOR=$(get_version_component_range 2 ${PV})

#slotting not yet supported
#SLOT="${MAJOR}.${MINOR}"
SLOT="0"
LICENSE="Intel-SDP"

IUSE="serial int64 fortran95 fftw doc examples"
RESTRICT="strip mirror"

DEPEND="app-admin/eselect-blas
	app-admin/eselect-cblas
	app-admin/eselect-lapack"

RDEPEND="${DEPEND}
	doc? ( app-doc/blas-docs app-doc/lapack-docs )"

MKL_DIR=/opt/intel/${PN}/${MAJOR}.${MINOR}

get_fcomp() {
	case $(tc-getFC) in
		*gfortran* )
			FCOMP="gfortran" ;;
		ifort )
			FCOMP="ifc" ;;
		* )
			FCOMP=$(tc-getFC) ;;
	esac
}

pkg_setup() {
	# setting up license
	[[ -z ${MKL_LICENSE} && -d /opt/intel/licenses ]] && \
		MKL_LICENSE=$(find /opt/intel/licenses -name *MKL*.lic)

	if  [[ -z ${MKL_LICENSE} ]]; then
		eerror "Did not find any valid mkl license."
		eerror "Please locate your license file and run:"
		eerror "\t MKL_LICENSE=/my/license/dir emerge ${PN}"
		eerror "or place your license in /opt/intel/licenses"
		eerror "Hint: the license file is in the email Intel sent you"
		die "setup mkl license failed"
	fi

	# setting up compilers
	MKL_CC=gnu
	[[ $(tc-getCC) == icc ]] && MKL_CC=icc
	get_fcomp
}

src_unpack() {

	ewarn
	local dp=950
	! use serial && ! use int64 && dp=400
	ewarn "Intel ${PN} requires ${dp}Mb of disk space"
	ewarn "Make sure you have enough in ${PORTAGE_TMPDIR}, /tmp and in /opt"
	ewarn
	unpack ${A}

	cd l_${PN}_*_${PV}/install

	# need to make a file to install non-interactively.
	# to produce such a file, first do it interactively
	# tar xf l_*; ./install.sh --duplicate mkl.ini;
	# the file will be instman/mkl.ini

	# binary blob extractor installs rpm leftovers in /opt/intel
	addwrite /opt/intel
	cp ${MKL_LICENSE} "${WORKDIR}"/
	MKL_LIC="$(basename ${MKL_LICENSE})"
	cat > mkl.ini <<- EOF
		[MKL]
		EULA_ACCEPT_REJECT=ACCEPT
		FLEXLM_LICENSE_LOCATION=${WORKDIR}/${MKL_LIC}
		INSTALLMODE=NONRPM
		INSTALL_DESTINATION=${S}
	EOF
	einfo "Extracting ..."
	./install \
		--silent ${PWD}/mkl.ini \
		--log log.txt &> /dev/null

	if [[ -z $(find "${S}" -name libmkl.so) ]]; then
		eerror "could not find extracted files"
		eerror "see ${PWD}/log.txt to see why"
		die "extracting failed"
	fi

	# remove unused stuff and set up intel names
	rm -rf "${WORKDIR}"/l_*
	case ${ARCH} in
		x86) MKL_ARCH=32
			MKL_KERN=ia32
			rm -rf "${S}"/lib*/*64*
			;;
		amd64) MKL_ARCH=em64t
			MKL_KERN=em64t
			rm -rf "${S}"/lib*/32 "${S}"/lib*/64
			;;
		ia64) MKL_ARCH=64
			MKL_KERN=ipf
			rm -rf "${S}"/lib*/32 "${S}"/lib*/em64t
			;;
	esac

	cd "${S}"

	# default profile regular is threaded
	MKL_PROF="regular"
	if use serial; then
		MKL_PROF="${MKL_PROF} serial"
	else
		[[ -d lib_serial ]] && rm -rf lib_serial
	fi
	if use int64; then
		MKL_PROF="${MKL_PROF} ilp64"
	else
		[[ -d lib_ilp64 ]] && rm -rf lib_ilp64
	fi

	# fix a bad makefile in the test
	if [[ $(tc-getFC) =~ gfortran ]] || [[ $(tc-getFC) =~ if.* ]]; then
		sed -i \
			-e "s/g77/$(tc-getFC)/" \
			-e 's/-DGNU_USE//' \
			tests/fftf/makefile || die "sed fftf test failed"
	fi
	# fix bad permissions on tools
	find tools -type f -perm /a+w ! -perm /a+x -exec chmod 644 '{}' \; \
		|| die "permissions fix failed"
}

src_compile() {

	if use fortran95; then
		for p in ${MKL_PROF}; do
			einfo "Compiling fortan95 static lib wrappers for ${p}"
			for x in blas95 lapack95; do
				cd "${S}"/interfaces/${x}
				emake \
					FC=$(tc-getFC) \
					MKL_SUBVERS=${p} \
					lib${MKL_ARCH} \
					|| die "emake $(basename ${x}) failed"
			done
		done
	fi

	if use fftw; then
		for p in ${MKL_PROF}; do
			einfo "Compiling fftw static lib wrappers for ${p}"
			for x in "${S}"/interfaces/fft*; do
				cd "${x}"
				emake -j1 \
					F=${MKL_CC} \
					MKL_SUBVERS=${p} \
					lib${MKL_ARCH} \
					|| die "emake $(basename ${x}) failed"
			done
		done
	fi
}

src_test() {
	local usegnu
	[[ $(tc-getFC) = g* ]] && usegnu=gnu
	# restrict tests for blas and cblas for now.
	# for t in blas cblas fft*; do
	for t in blas lapack; do
		cd "${S}"/tests/${t}
		for p in ${MKL_PROF}; do
			einfo "Testing ${t} for ${p}"
			emake -j1 \
				F=${usegnu} \
				FC=$(tc-getFC) \
				MKL_SUBVERS=${p} \
				lib${MKL_ARCH} \
				|| die "emake ${t} failed"
		done
	done
}

# usage: mkl_install_lib <serial|regular|ilp64>
mkl_install_lib() {

	local proflib=lib_${1}
	local prof=${PN}-${1}
	[[ "${1}" == "regular" ]] && proflib=lib && prof=${PN}-threads
	local libdir="${MKL_DIR}/${proflib}/${MKL_ARCH}"
	local extlibs="-L${libdir} -lguide -lpthread"
	[[ "${1}" == "serial" ]] && extlibs=""

	[[ $(tc-getFC) =~ gfortran ]] && \
		gfortranlibs="-L${libdir} -lmkl_gfortran"

	cp -pPR "${S}"/${proflib} "${D}"${MKL_DIR}

	for x in blas cblas; do
		cat  > eselect.${x}.${prof} <<- EOF
			${libdir}/libmkl_${MKL_KERN}.a /usr/@LIBDIR@/lib${x}.a
			${libdir}/libmkl.so /usr/@LIBDIR@/lib${x}.so
			${libdir}/libmkl.so /usr/@LIBDIR@/lib${x}.so.0
			${libdir}/${x}.pc /usr/@LIBDIR@/pkgconfig/${x}.pc
		EOF

		[[ ${x} == cblas ]] && \
			echo "${MKL_DIR}/include/mkl_cblas.h /usr/include/cblas.h" \
			>> eselect.${x}.${prof}
		eselect ${x} add $(get_libdir) eselect.${x}.${prof} ${prof}
		sed -e "s:@LIBDIR@:$(get_libdir):" \
			-e "s:@INCDIR@:${MKL_DIR}/include:" \
			-e "s:@PV@:${PV}:" \
			-e "s:@EXTLIBS@:${extlibs}:g" \
			-e "s:@GFORTRANLIBS@:${gfortranlibs}:g" \
			"${FILESDIR}"/${x}.pc.in > ${x}.pc || die "sed ${x}.pc failed"
		insinto ${libdir}
		doins ${x}.pc
	done

	cat > eselect.lapack.${prof} <<- EOF
		${libdir}/libmkl_lapack.a /usr/@LIBDIR@/liblapack.a
		${libdir}/libmkl_lapack.so /usr/@LIBDIR@/liblapack.so
		${libdir}/libmkl_lapack.so /usr/@LIBDIR@/liblapack.so.0
		${libdir}/lapack.pc /usr/@LIBDIR@/pkgconfig/lapack.pc
	EOF
	sed -e "s:@LIBDIR@:$(get_libdir):" \
		-e "s:@PV@:${PV}:" \
		-e "s:@EXTLIBS@:${extlibs}:g" \
		-e "s:@GFORTRANLIBS@:${gfortranlibs}:g" \
		"${FILESDIR}"/lapack.pc.in > lapack.pc || die "sed lapack.pc failed"
	insinto ${libdir}
	doins lapack.pc

	eselect lapack add $(get_libdir) eselect.lapack.${prof} ${prof}
	echo "LDPATH=${libdir}"
}

src_install() {

	# install license
	if  [[ ! -f /opt/intel/licenses/${MKL_LIC} ]]; then
		insinto /opt/intel/licenses
		doins "${WORKDIR}"/${MKL_LIC} || die "install license failed"
	fi

	dodir ${MKL_DIR}
	# keep intel dir in /opt as default install
	einfo "Installing headers, man pages and tools"
	# use cp, too slow with doins
	cp -pPR include man tools "${D}"${MKL_DIR} || die "install include|man|tools failed"

	if use examples; then
		einfo "Installing examples"
		cp -pPR examples "${D}"${MKL_DIR} || die "install examples failed"
	fi

	insinto ${MKL_DIR}/doc
	doins doc/*.txt || die "basic doc install failed"
	if use doc; then
		einfo "Installing documentation"
		cp -pPR doc/*.pdf doc/*.htm "${D}"${MKL_DIR}/doc || die "doc failed"
	fi

	# take care of lib and eselect files
	local env_file=35mkl
	for p in ${MKL_PROF}; do
		einfo "Installing profile: ${p}"
		mkl_install_lib ${p} > ${env_file}
	done

	echo "MANPATH=${MKL_DIR}/man"  >> ${env_file}
	doenvd ${env_file} || die "doenvd failed"
}

pkg_postinst() {
	# set default profile according to upstream
	local ext=threads
	if use int64; then
		ext=int64
	elif use serial; then
		ext=serial
	fi
	ESELECT_PROF="${PN}-${FCOMP}-${ext}"
	# if blas profile is mkl, set lapack and cblas profiles as mkl
	local blas_lib=$(eselect blas show | cut -d' ' -f2)
	for p in blas cblas lapack; do
		local current_lib=$(eselect ${p} show | cut -d' ' -f2)
		if [[ -z ${current_lib} || \
			${current_lib} == ${ESELECT_PROF} || \
			${blas_lib} == ${ESELECT_PROF} ]]; then
			# work around eselect bug #189942
			local configfile="${ROOT}"/etc/env.d/${p}/$(get_libdir)/config
			[[ -e ${configfile} ]] && rm -f ${configfile}
			eselect ${p} set ${ESELECT_PROF}
			elog "${p} has been eselected to ${ESELECT_PROF}"
			if [[ ${current_lib} != ${blas_lib} ]]; then
				eselect blas set ${ESELECT_PROF}
				elog "${p} has been eselected to ${ESELECT_PROF} for consistency"
			fi
		else
			elog "Current eselected ${p} is ${current_lib}"
			elog "To use ${p} ${ESELECT_PROF} implementation, you have to issue (as root):"
			elog "\t eselect ${p} set ${ESELECT_PROF}"
		fi
	done
}
