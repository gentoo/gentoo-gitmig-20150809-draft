# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-11.1.046-r1.ebuild,v 1.2 2009/08/22 02:34:13 weaver Exp $

EAPI="2"

PID=1536
PB=cproc
DESCRIPTION="Intel C/C++ optimized compiler for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/clin/"

###
# everything below common to ifc and icc
# no eclass: very likely to change for next versions
###
PACKAGEID="l_${PB}_p_${PV}"
RELEASE="${PV:0:4}"
BUILD="${PV:5:8}"
SRC_URI="http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}.tgz"
#SRC_URI="amd64? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_intel64.tgz )
#	ia64? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_ia64.tgz )
#	x86?  ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_ia32.tgz )"

LICENSE="Intel-SDP"
SLOT="0"
IUSE=""
KEYWORDS=""

RESTRICT="mirror strip binchecks"

INSTALL_DIR="opt/intel/Compiler/${RELEASE}/${BUILD}"
# these don't work, not sure why
#QA_TEXTRELS="${INSTALL_DIR}"
#QA_WX_LOAD="${INSTALL_DIR}"
#QA_PRESTRIPPED="${INSTALL_DIR}"

DEPEND="app-arch/rpm"
RDEPEND="virtual/libstdc++
	amd64? ( app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}/${PACKAGEID}"

src_prepare() {
	use amd64 || rm -f rpm/*x86_64.rpm
	# debugger installed with dev-lang/idb
	rm -f rpm/intel*idb*.rpm
	# performance primitives installed with sci-libs/ipp
	rm -f rpm/intel*ipp*.rpm
	# math library installed with sci-libs/mkl
	rm -f rpm/intel*mkl*.rpm
}

src_install() {
	mkdir "${WORKDIR}/rpmdb"
	# rpm open_wr's / but doesn't seem to do anything with it
	addpredict /
	rpm --install --nodeps --dbpath "${WORKDIR}/rpmdb" --prefix "${D}/${INSTALL_DIR}" rpm/*.rpm || die

	find "${D}/${INSTALL_DIR}" -name '*.csh' | xargs sed -i "s|${D}|${ROOT}|" || die
	find "${D}/${INSTALL_DIR}" -name '*.sh' | xargs sed -i "s|${D}|${ROOT}|" || die

	ENV_FILE=05${PN}
	MYARCH=""
	if use amd64; then MYARCH=intel64; fi
	if use ia64; then MYARCH=ia64; fi
	if use x86; then MYARCH=ia32; fi

	env - bash --noprofile --norc -c "source '${D}/${INSTALL_DIR}/bin/iccvars.sh' ${MYARCH}; env|egrep -v '(PWD|SHLVL|_)='" > ${ENV_FILE}
	doenvd ${ENV_FILE} || die

	# PROFILE_FILE=${PN}.sh
	# echo "source ${ROOT}${INSTALL_DIR}/bin/iccvars.sh ${MYARCH}" >> ${PROFILE_FILE}
	# exeinto /etc/profile.d; doexe ${PROFILE_FILE} || die

	mkdir -p "${D}/opt/intel/licenses"
}

pkg_postinst() {
	elog "${PN} requires a license file in order to run."
	elog "To receive a restrictive non-commercial license, please register at:"
	elog "http://www.intel.com/cd/software/products/asmo-na/eng/download/download/219771.htm"
	elog "Read the website for more information on this license."
	elog "Install the license file into ${ROOT}opt/intel/licenses"
	elog
	elog "The following packages provide components bundled with icc:"
	elog "\t dev-lang/idb"
	elog "\t sci-libs/ipp"
	elog "\t sci-libs/mkl"
}
