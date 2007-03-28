# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-9.1.040.ebuild,v 1.3 2007/03/28 15:18:51 armin76 Exp $

inherit rpm versionator

MAJOR=$(get_major_version ${PV})
MINOR=$(get_version_component_range 2 ${PV})

DESCRIPTION="Intel Fortran Compiler for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/flin/"
IUSE=""
KEYWORDS="~amd64 ia64 x86"
LICENSE="ifc-9.0"
RESTRICT="nostrip fetch"
SLOT="${MAJOR}.${MINOR}"
MMV="${MAJOR}.${MINOR}"

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
			rm -f data/intel-*.{i386,ia64}.rpm
			;;
		ia64)
			rm -f data/intel-*.{em64t,i386}.rpm
			;;
		x86)
			rm -f data/intel-*.{em64t,ia64}.rpm
			;;
	esac

	for x in *.rpm
	do
		# WORKDIR must be set properly for rpm_unpack()
		rpm_unpack ${S}/data/${x}
	done

}

src_compile() {
	instdir=/opt/intel/fortran${MMV//.}

	for x in opt/intel/*/*/bin/* ; do
		sed "s|<INSTALLDIR>|${instdir}|g" -i $x
	done

	# == SRC_BASE
	eval `grep "^[ ]*PACKAGEID=" ${S}/data/install_fc.sh`
	einfo "PACKAGEID=${PACKAGEID}"

	# From UNTAG_SUPPORT() in 'install_fc.sh'
	case ${ARCH} in
		amd64)
			SUPPORTFILE=${S}/opt/intel/fce/${MMV}*/doc/fesupport
			;;
		ia64|x86)
			SUPPORTFILE=${S}/opt/intel/fc/${MMV}*/doc/fsupport
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
			SUPPORTFILE=${S}/opt/intel/idbe/${MMV}*/doc/idbesupport
			;;
		ia64 | x86)
			SUPPORTFILE=${S}/opt/intel/idb/${MMV}*/doc/idbsupport
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
	instdir=/opt/intel/fortran${MMV//.}
	# No lgpltext in ifc
	# dodoc ${S}/lgpltext
	dodoc ${S}/flicense
	dodir ${instdir}
	cp -pPR opt/intel/fc*/${MMV}*/* ${D}/${instdir}
	cp -pPR opt/intel/idb*/${MMV}*/* ${D}/${instdir}
	insinto /etc/env.d
	doins ${FILESDIR}/${MMV}/05ifc || die
}

pkg_postinst () {
	instdir=/opt/intel/fortran${MMV//.}

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
