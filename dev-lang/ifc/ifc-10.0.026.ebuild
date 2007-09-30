# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-10.0.026.ebuild,v 1.1 2007/09/30 10:34:44 bicatali Exp $

inherit rpm elisp-common

PID=787
PB=fc
PEXEC=ifort
DESCRIPTION="Intel FORTRAN 77/95 optimized compiler for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/flin/"

###
# everything below common to ifc and icc
# no eclass: very likely to change for next versions
###
PACKAGEID="l_${PB}_c_${PV}"
KEYWORDS="~amd64 ~ia64 ~x86"
SRC_URI="amd64? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_intel64.tar.gz )
	ia64? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_ia64.tar.gz )
	x86?  ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_ia32.tar.gz )"

LICENSE="Intel-SDP"
SLOT="0"

RESTRICT="test strip mirror"
IUSE="emacs debugger"

DEPEND=""
RDEPEND="debugger? (
	x11-libs/libXt
	x11-libs/libXft
	dev-libs/libxml2
	virtual/libstdc++ )"

if use x86; then
	MY_P="${PACKAGEID}_ia32"
elif use amd64; then
	MY_P="${PACKAGEID}_intel64"
elif use ia64; then
	MY_P="${PACKAGEID}_ia64"
fi

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	local ext=
	use amd64 && ext=e
	INSTALL_DIR=/opt/intel/${PB}${ext}/${PV}

	if use debugger && [[ ! -x /opt/intel/idb${ext}/${PV}/bin/idb ]]; then
		INSTALL_IDB_DIR=/opt/intel/idb${ext}/${PV}
	else
		use debugger && einfo "Debugger already installed"
		rm -f data/intel*idb*.rpm
	fi

	for x in data/intel*.rpm; do
		einfo "Extracting $(basename ${x})..."
		rpm_unpack "${S}/${x}" || die "rpm_unpack ${x} failed"
	done

	einfo "Fixing paths and tagging"
	cd "${S}"/${INSTALL_DIR}/bin
	sed -e "s|<INSTALLDIR>|${INSTALL_DIR}|g" \
		-i ${PEXEC} ${PEXEC}*sh \
		|| die "sed fixing path failed"

	cd "${S}"/${INSTALL_DIR}/doc
	sed -e "s|\<installpackageid\>|${PACKAGEID}|g" \
		-e "s|\<INSTALLTIMECOMBOPACKAGEID\>|${PACKAGEID}|g" \
		-i *support \
		|| die "sed support file failed"
	chmod 644 *support
}

src_install() {
	einfo "Copying files"
	dodir ${INSTALL_DIR}
	cp -pPR \
		"${S}"/${INSTALL_DIR}/* \
		"${D}"/${INSTALL_DIR}/ \
		|| die "copying ${PN} failed"

	local env_file=05${PN}
	echo "PATH=${INSTALL_DIR}/bin" > ${env_file}
	echo "ROOTPATH=${INSTALL_DIR}/bin" >> ${env_file}
	echo "LDPATH=${INSTALL_DIR}/lib" >> ${env_file}
	echo "MANPATH=${INSTALL_DIR}/man" >> ${env_file}
	echo "INCLUDE=${INSTALL_DIR}/include" >> ${env_file}
	echo "IA32ROOT=${INSTALL_DIR}" >> ${env_file}
	doenvd ${env_file} || die "doenvd ${env_file} failed"

	if [[ -n ${INSTALL_IDB_DIR} ]]; then
		dodir ${INSTALL_IDB_DIR}
		cp -pPR \
			"${S}"/${INSTALL_IDB_DIR}/* \
			"${D}"/${INSTALL_IDB_DIR}/ \
			|| die "copying debugger failed"
		local idb_env_file=06idb
		echo "PATH=${INSTALL_IDB_DIR}/bin" > ${idb_env_file}
		echo "ROOTPATH=${INSTALL_IDB_DIR}/bin" >> ${idb_env_file}
		echo "MANPATH=${INSTALL_IDB_DIR}/man" >> ${idb_env_file}
		doenvd ${idb_env_file} || die "doenvd ${idb_env_file} failed"
		use emacs && \
			elisp-site-file-install "${S}"${INSTALL_IDB_DIR}/bin/*.el
	fi
}

pkg_postinst () {
	elog "Make sure you have recieved the restrictive"
	elog "non-commercial license ${PN} by registering at:"
	elog "http://www.intel.com/cd/software/products/asmo-na/eng/download/download/219771.htm"
	elog "You cannot run ${PN} without this license file."
	elog "Read the website for more information on this license."
	elog "To use ${PN} now, issue first \n\tsource /etc/profile"
	use emacs && elisp-site-regen
	rm -f "${ROOT}"/opt/intel/{intel_sdp_products.db,.*.log}
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
