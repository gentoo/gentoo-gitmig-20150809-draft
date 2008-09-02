# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/idb/idb-10.1.018.ebuild,v 1.1 2008/09/02 09:45:52 bicatali Exp $

inherit rpm elisp-common

ICC_PID=1205
IFC_PID=1208
xPV=p_${PV}

DESCRIPTION="Intel C/C++/FORTRAN debugger for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/"
COM_URI="http://registrationcenter-download.intel.com/irc_nas"
SRC_URI="amd64? ( ifc? ( !icc? ( ${COM_URI}/${IFC_PID}/l_fc_${xPV}_intel64.tar.gz ) )
				 !ifc? ( !icc? ( ${COM_URI}/${ICC_PID}/l_cc_${xPV}_intel64.tar.gz ) )
						  icc? ( ${COM_URI}/${ICC_PID}/l_cc_${xPV}_intel64.tar.gz ) )
		  ia64? ( ifc? ( !icc? ( ${COM_URI}/${IFC_PID}/l_fc_${xPV}_ia64.tar.gz ) )
				 !ifc? ( !icc? ( ${COM_URI}/${ICC_PID}/l_cc_${xPV}_ia64.tar.gz ) )
						  icc? ( ${COM_URI}/${ICC_PID}/l_cc_${xPV}_ia64.tar.gz ) )
		   x86? ( ifc? ( !icc? ( ${COM_URI}/${IFC_PID}/l_fc_${xPV}_ia32.tar.gz ) )
				 !ifc? ( !icc? ( ${COM_URI}/${ICC_PID}/l_cc_${xPV}_ia32.tar.gz ) )
						  icc? ( ${COM_URI}/${ICC_PID}/l_cc_${xPV}_ia32.tar.gz ) )"

KEYWORDS="~amd64 ~x86"

LICENSE="Intel-SDP"
SLOT="0"

RESTRICT="strip mirror"
IUSE="emacs icc ifc"

DEPEND=""
RDEPEND="virtual/libstdc++
	x11-libs/libXft
	x11-libs/libXt
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	PACKAGEID=$(basename l_*)
	mv "${WORKDIR}"/${PACKAGEID} "${S}"
	cd "${S}"
	for x in data/*idb*.rpm; do
		einfo "Extracting $(basename ${x})..."
		rpm_unpack ${x} || die "rpm_unpack ${x} failed"
	done
}

src_install() {
	local ext=
	use amd64 && ext=e
	local instdir=/opt/intel/${PN}${ext}/${PV}
	cd "${S}"/${instdir}/doc
	sed -e "s|\<installpackageid\>|${PACKAGEID}|g" \
		-i *support \
		|| die "sed support file failed"
	chmod 644 *support

	dodir ${instdir}
	einfo "Copying files"
	cp -pPR \
		"${S}"/${instdir}/* \
		"${D}"/${instdir}/ \
		|| die "copying debugger failed"
	cat > 06idb <<-EOF
		PATH=${instdir}/bin
		ROOTPATH=${instdir}/bin
		MANPATH=${instdir}/man
	EOF
	doenvd 06idb || die "installing env file failed"
	use emacs && \
		elisp-site-file-install "${S}"${instdir}/bin/*.el
}

pkg_postinst () {
	rm -f "${ROOT}"/opt/intel/{intel_sdp_products.db,.*.log} || die
	elog "Make sure you have recieved the a license for ${PN},"
	elog "you cannot run ${PN} without a license file."
	elog "To receive a non-commercial license, you need to register."
	elog "Read the website for more information on this license:"
	elog "${HOMEPAGE}"
	elog "Then put the license file into ${ROOT}/opt/intel/licenses."
	elog "\nTo use ${PN} issue first \n\tsource ${ROOT}/etc/profile"
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
