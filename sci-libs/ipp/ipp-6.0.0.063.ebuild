# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ipp/ipp-6.0.0.063.ebuild,v 1.3 2009/01/28 23:02:15 bicatali Exp $

inherit check-reqs

PID=1243
PB=${PN}
DESCRIPTION="Intel(R) Integrated Performance Primitive library for multimedia and data processing"
HOMEPAGE="http://developer.intel.com/software/products/ipp/"

KEYWORDS="~amd64 ~x86 ~ia64"
COM_URI="http://registrationcenter-download.intel.com/irc_nas/${PID}"
SRC_URI="amd64? ( ${COM_URI}/l_${PB}_em64t_p_${PV}.tar.gz )
	x86? ( ${COM_URI}/l_${PB}_ia32_p_${PV}.tar.gz )
	ia64? ( ${COM_URI}/l_${PB}_itanium_p_${PV}.tar.gz )"

SLOT="0"
LICENSE="Intel-SDP"

IUSE=""
RESTRICT="strip mirror binchecks"

INTEL_LIC_DIR=/opt/intel/licenses

pkg_setup() {
	# Check the license
	if [[ -z ${IPP_LICENSE} ]]; then
		IPP_LICENSE="$(grep -ls PerfPrim ${ROOT}${INTEL_LIC_DIR}/* | tail -n 1)"
		IPP_LICENSE=${IPP_LICENSE/${ROOT}/}
	fi
	if  [[ -z ${IPP_LICENSE} ]]; then
		eerror "Did not find any valid ipp license."
		eerror "Register at ${HOMEPAGE} to receive a license"
		eerror "and place it in ${INTEL_LIC_DIR} or run:"
		eerror "export IPP_LICENSE=/my/license/file emerge ipp"
		die "license setup failed"
	fi

	local disq_req
	IPP_ARCH=
	if use amd64; then
		IPP_ARCH="em64t"
		disk_req="800"
	elif use x86; then
		IPP_ARCH="ia32"
		disk_req="600"
	elif use ia64; then
		IPP_ARCH="ia64"
		disk_req="700"
	fi
	einfo "IPP_LICENSE=${IPP_LICENSE}"
	einfo "IPP_ARCH=${IPP_ARCH}"

	# Check if we have enough RAM and free diskspace
	CHECKREQS_MEMORY="512"
	CHECKREQS_DISK_BUILD=${disk_req}
	check_reqs
}

src_unpack() {
	unpack ${A}
	cd l_${PB}_*_${PV}

	# need to make a file to install non-interactively.
	# to produce such a file, first do it interactively
	# tar xf l_*; ./install.sh --duplicate ipp.ini;

	# binary blob extractor uses stupid directory
	addpredict /usr/local/share/macrovision

	cp ${IPP_LICENSE} "${WORKDIR}"/
	cat > ipp.ini <<- EOF
		ACTIVATION=license_file
		CONTINUE_WITH_OPTIONAL_ERROR=yes
		PSET_INSTALL_DIR=${S}
		PSET_LICENSE_FILE=${IPP_LICENSE}
		INSTALL_MODE=NONRPM
		ACCEPT_EULA=accept
	EOF

	einfo "Extracting ..."
	./install.sh --silent ${PWD}/ipp.ini &> log.txt

	# This check is arbitrary to say the least...
	# We used to look for a specific library (ie: libippmmx.so) but that
	# is unreliable as they are moving targets and may not be there on
	# the next release. ippEULA.txt is more likely to remain there at
	# the next release.
	if [[ -z $(find "${S}" -name ippEULA.txt) ]]; then
		eerror "could not find extracted files"
		eerror "see ${PWD}/log.txt to see why"
		die "extracting failed"
	fi

	# clean up
	cd "${S}"
	find . -type d -print0 | xargs --null chmod 755
	rm -rf tmp* uninstall.sh
	rm -rf "${WORKDIR}"/l_*
}

src_install() {
	local instdir=/opt/intel/${PN}/${PV}/${IPP_ARCH}
	dodir ${instdir}

	# install license file
	if  [[ ! -f ${INTEL_LIC_DIR}/$(basename ${IPP_LICENSE}) ]]; then
		insinto ${INTEL_LIC_DIR}
		doins ${IPP_LICENSE}
	fi

	# cp quicker than doins
	einfo "Copying all files"
	cp -pPR "${S}"/* "${D}"${instdir} || \
		die "copying files failed"

	local env_file=36ipp
	echo "LDPATH=${instdir}/sharedlib" > ${env_file}
	doenvd ${env_file} || die "doenvd ${env_file} failed"
}
