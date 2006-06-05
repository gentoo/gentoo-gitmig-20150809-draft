# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-9.0.031.ebuild,v 1.1 2006/06/05 17:11:48 spyderous Exp $

inherit rpm

DESCRIPTION="Intel Fortran Compiler for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/flin/"
IUSE=""
KEYWORDS="~amd64 ~ia64 ~x86"
LICENSE="ifc-9.0"
RESTRICT="nostrip fetch"
SLOT="9.0"
MMV="9.0"

SRC_URI="l_fc_c_${PV}.tar.gz"
DEPEND=">=sys-libs/glibc-2.3.2"
RDEPEND="sys-devel/gcc"
S="${WORKDIR}/l_fc_c_${PV}"

src_unpack() {
	unpack ${A}

	cd ${S} || die

	# The tarball contains rpms for multiple arches, and a lot of
	# auxiliary rpms common across arches. We must throw away 
	# the arch we're not.
	case ${ARCH} in
		amd64)
			rm -f intel-*.{i386,ia64}.rpm
			;;
		ia64)
			rm -f intel-*.{em64t,i386}.rpm
			;;
		x86)
			rm -f intel-*.{em64t,ia64}.rpm
			;;
	esac

	for x in *.rpm
	do
		# WORKDIR must be set properly for rpm_unpack()
		rpm_unpack ${S}/${x}
	done

}

src_compile() {
	instdir=/opt/intel/fortran90

	for x in opt/intel/*/*/bin/* ; do
		sed "s|<INSTALLDIR>|${instdir}|g" -i $x
	done

	# == SRC_BASE
	eval `grep "^[ ]*PACKAGEID=" ${S}/install_fc.sh`
	einfo "PACKAGEID=${PACKAGEID}"

	# From UNTAG_SUPPORT() in 'install_fc.sh'
	case ${ARCH} in
		amd64)
			SUPPORTFILE=${S}/opt/intel/fce/9.0/doc/fesupport
			;;
		ia64|x86)
			SUPPORTFILE=${S}/opt/intel/fc/9.0/doc/fsupport
			;;
	esac
	if [ -f ${SUPPORTFILE} ]
	then
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<installpackageid\>@${PACKAGEID}@g ${SUPPORTFILE} > ${SUPPORTFILE}.abs
		mv ${SUPPORTFILE}.abs ${SUPPORTFILE}
		chmod 644 ${SUPPORTFILE}
	fi

	# From UNTAG_SUPPORT_IDB() in 'install_fc.sh'
	case ${ARCH} in
		amd64)
			SUPPORTFILE=${S}/opt/intel/idbe/9.0/doc/idbesupport
			;;
		ia64 | x86)
			SUPPORTFILE=${S}/opt/intel/idb/9.0/doc/idbsupport
			;;
	esac
	if [ -f ${SUPPORTFILE} ]
	then
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<INSTALLTIMECOMBOPACKAGEID\>@${PACKAGEID}@g ${SUPPORTFILE} > ${SUPPORTFILE}.abs
		mv ${SUPPORTFILE}.abs ${SUPPORTFILE}
		chmod 644 ${SUPPORTFILE}
	fi
}

src_install () {
	instdir=/opt/intel/fortran90
	# No lgpltext in ifc
	# dodoc ${S}/lgpltext
	dodoc ${S}/flicense
	dodir ${instdir}
	cp -pPR opt/intel/fc*/9.0/* ${D}/${instdir}
	cp -pPR opt/intel/idb*/9.0/* ${D}/${instdir}
	insinto /etc/env.d
	doins ${FILESDIR}/${MMV}/05ifc || die
}

pkg_postinst () {
	instdir=/opt/intel/fortran90

	einfo "http://www.intel.com/software/products/compilers/flin/noncom.htm"
	einfo "From the above url you can get a free, non-commercial"
	einfo "license to use the Intel Fortran Compiler emailed to you."
	einfo "You cannot run ifc without this license file."
	einfo "Read the website for more information on this license."
	einfo
	einfo "Documentation can be found in ${instdir}/doc/"
	einfo
	einfo "You will need to place your license in ${instdir}/licenses/"
	echo

	ewarn "If 'ifc' breaks, use 'ifortbin' instead and report a bug."
	echo

	ewarn "Please perform"
	ewarn "  env-update"
	ewarn "  source /etc/profile"
	ewarn "prior to using ifc."
}
