# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ipp/ipp-5.3.2.068.ebuild,v 1.1 2008/03/13 21:20:58 bicatali Exp $

inherit versionator multilib check-reqs

PID=980
PB=${PN}
DESCRIPTION="Intel(R) Integrated Performance Primitive library for multimedia and data processing"
HOMEPAGE="http://developer.intel.com/software/products/ipp/"

KEYWORDS="~amd64 ~x86 ~ia64"
COM_URI="http://registrationcenter-download.intel.com/irc_nas/${PID}"
SRC_URI="amd64? ( ${COM_URI}/l_${PB}_em64t_p_${PV}.tgz )
	x86? ( ${COM_URI}/l_${PB}_ia32_p_${PV}.tgz )
	ia64? ( ${COM_URI}/l_${PB}_itanium_p_${PV}.tgz )"

SLOT=0
LICENSE="Intel-SDP"

IUSE=""
RESTRICT="strip mirror"

pkg_setup() {
	# setting up license
	[[ -z ${IPP_LICENSE} ]] && [[ -d ${ROOT}/opt/intel/licenses ]] && \
		IPP_LICENSE="$(find ${ROOT}/opt/intel/licenses -name *IPP*.lic)"
	# Alternative license file, the file might be included in a `package deal`
	[[ -z ${IPP_LICENSE} ]] && \
		IPP_LICENSE="$(grep 'COMPONENTS="PerfPrimL PerfPrim"' ${ROOT}/opt/intel/licenses/*|cut -d: -f1)"

	if  [[ -z ${IPP_LICENSE} ]]; then
		eerror "Did not find any valid ipp license."
		eerror "Please locate your license file and run:"
		eerror "\t IPP_LICENSE=/my/license/dir emerge ${PN}"
		eerror "or place your license in /opt/intel/licenses"
		eerror "Hint: the license file is in the email Intel sent you"
		die "setup ipp license failed"
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

	ewarn
	ewarn "Intel ${PN} requires at least 300Mb of disk space"
	ewarn "Make sure you have enough in ${PORTAGE_TMPDIR}, /tmp and in /opt"
	ewarn
	unpack ${A}

	cd l_${PB}_*_${PV}/install
	# need to make a file to install non-interactively.
	# to produce such a file, first do it interactively
	# tar xf l_*; ./install.sh --duplicate ipp.ini;
	# the file will be instman/ipp.ini
	# binary blob extractor installs crap in /opt/intel
	addwrite /opt/intel
	cp ${IPP_LICENSE} "${WORKDIR}"/
	IPP_TMP_LICENSE="$(basename ${IPP_LICENSE})"
	cat > ipp.ini <<- EOF
		[IPP_${IPP_ARCH}]
		EULA_ACCEPT_REJECT=ACCEPT
	EOF
	einfo "Extracting ..."
	./install \
		--silent ${PWD}/ipp.ini \
		--nonrpm \
		--licensepath "${WORKDIR}"/${IPP_TMP_LICENSE} \
		--installpath "${S}" \
		--log log.txt &> /dev/null

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

	rm -rf "${WORKDIR}"/l_*
}

src_compile() {
	einfo "Binary package, nothing to compile"
}

src_install() {
	local instdir=/opt/intel/${PN}/${PV}/${IPP_ARCH}
	dodir ${instdir}

	# install license file
	if  [[ ! -f /opt/intel/licenses/${IPP_TMP_LICENSE} ]]; then
		insinto /opt/intel/licenses
		doins "${WORKDIR}"/${IPP_TMP_LICENSE}
	fi

	# cp quicker than doins
	einfo "Copying all files"
	cp -pPR "${S}"/* "${D}"${instdir} || \
		die "copying files failed"

	local env_file=36ipp
	echo "LDPATH=${instdir}/sharedlib" > ${env_file}
	doenvd ${env_file} || die "doenvd ${env_file} failed"
}
