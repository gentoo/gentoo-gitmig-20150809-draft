# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-8.1.026.ebuild,v 1.1 2005/05/26 22:50:39 kugelfang Exp $

inherit rpm

DESCRIPTION="Intel Fortran Compiler 8.1 for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/flin/"
SRC_URI="l_fc_pc_${PV}.tar.gz"
# no EM64T version of 8.1.026
KEYWORDS="-* ~ia64 ~x86"
SLOT="8.1"
LICENSE="ifc-8.1"
IUSE=""

RESTRICT="nostrip fetch"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	case ${ARCH} in
		x86|amd64)
			rpm_unpack ${S}/intel-*.i386.rpm || die "Failed to unpack rpms!"
			;;
		ia64)
			rpm_unpack ${S}/intel-*.ia64.rpm || die "Failed to unpack rpms!"
			;;
		*)
			eerror "Wrong architecture. The Intel Fortran Compiler can only be used on x86, amd64 and ia64."
			die "Wrong architecture !"
	esac
	rm -Rf ${S}/${P/ifc-/l_fc\*_p\*_}
}

src_compile() {
	return
}

src_install() {
	mv ${S}/opt ${D}/

	local SUFFIX
	use amd64 && SUFFIX="e"

	for FILE in ${D}/opt/intel_fc${SUFFIX}_80/bin/{ifc,ifort}; do
		sed -i \
			-e "s|<INSTALLDIR>|/opt/intel_fc${SUFFIX}_80|g" \
			-e "s|^EFI2_INCLUDE1=.*|EFI2_INCLUDE1=\$(gcc-config -X); \
				EFI2_INCLUDE1=\${EFI2_INCLUDE1##*:}; export EFI2_INCLUDE1;|g" \
			-e "s|/usr/lib/gcc-lib/x86_64-redhat-linux|/usr/${CHOST}|g" \
			-e "s|/usr/local/include|/usr/include|g" ${FILE} \
			|| die "sed failed! (${FILE})"
		chmod 755 ${FILE}
	done
}

pkg_postinst() {
	local SUFFIX
	use amd64 && SUFFIX="e"
	einfo
	einfo "http://www.intel.com/software/products/compilers/flin/noncom.htm"
	einfo
	einfo "From the above url you can get a free, non-time limited, non-commercial"
	einfo "personal use license key that comes with no support. You will need to read"
	einfo "and agree to the license and then fill in your info to have one emailed to"
	einfo "you. Read the website for details."
	einfo
	einfo "The Intel Fortran Compiler needs your license file in either /opt/intel_fc${SUFFIX}_80/licenses/"
	einfo "or in a location that INTEL_LICENSE_FILE points to."
	einfo
	einfo "Documentation for the compiler can be found in /opt/intel_fc${SUFFIX}_80/doc/"
	einfo
}
