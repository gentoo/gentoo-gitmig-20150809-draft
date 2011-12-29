# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-10.0.026-r1.ebuild,v 1.17 2011/12/29 12:44:32 jlec Exp $

inherit rpm eutils

PID=787
PB=fc
PEXEC=ifort
PACKAGEID="l_${PB}_c_${PV}"

DESCRIPTION="Intel FORTRAN 77/95 optimized compiler for Linux"
HOMEPAGE="http://software.intel.com/en-us/articles/fortran-compilers/"
SRC_URI="
	amd64? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_intel64.tar.gz )
	ia64? ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_ia64.tar.gz )
	x86?  ( http://registrationcenter-download.intel.com/irc_nas/${PID}/${PACKAGEID}_ia32.tar.gz )"

LICENSE="Intel-SDP"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	~virtual/libstdc++-3.3
	amd64? ( app-emulation/emul-linux-x86-compat )"

RESTRICT="test strip mirror"

pkg_setup() {
	if has_version "<dev-lang/${P}"; then
		ewarn "${PN}-9.x detected, probably with slotting."
		ewarn "This version has many bugs and was installed with slotting."
		ewarn "You might want to do an emerge -C ${PN} first"
		epause 10
	fi
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/l_* "${S}"
	cd "${S}"

	local ext=
	use amd64 && ext=e
	INSTALL_DIR=/opt/intel/${PB}${ext}/${PV}

	# debugger installed with dev-lang/idb
	rm -f data/intel*idb*.rpm

	for x in data/intel*.rpm; do
		einfo "Extracting $(basename ${x})..."
		rpm_unpack "${x}" || die "rpm_unpack ${x} failed"
	done

	einfo "Fixing paths and tagging"
	cd "${S}"/${INSTALL_DIR}/bin
	sed -e "s|<INSTALLDIR>|${INSTALL_DIR}|g" \
		-e 's|export -n IA32ROOT;||g' \
		-i ${PEXEC} *sh \
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
	doenvd ${env_file} || die "doenvd ${env_file} failed"
}

pkg_postinst () {
	# remove left over from unpacking
	rm -f "${ROOT}"/opt/intel/{intel_sdp_products.db,.*.log} || die "remove logs failed"

	elog "Make sure you have recieved the a license for ${PN}"
	elog "To receive a restrictive non-commercial licenses , you need to register at:"
	elog "http://www.intel.com/cd/software/products/asmo-na/eng/download/download/219771.htm"
	elog "Read the website for more information on this license."
	elog "You cannot run ${PN} without a license file."
	elog "Then put the license file into ${ROOT}/opt/intel/licenses"
	elog "\nTo use ${PN} issue first \n\tsource /etc/profile"
	elog "Debugger is installed with dev-lang/idb"
}
