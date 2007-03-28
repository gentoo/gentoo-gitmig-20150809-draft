# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-9.1.045.ebuild,v 1.4 2007/03/28 15:17:01 armin76 Exp $

inherit rpm versionator

MAJOR=$(get_major_version ${PV})
MINOR=$(get_version_component_range 2 ${PV})

DESCRIPTION="Intel C++ Compiler - Intel's optimized compiler for Linux"
SRC_URI="l_cc_c_${PV}.tar.gz"
HOMEPAGE="http://www.intel.com/software/products/compilers/clin/"
LICENSE="icc-9.0"
RDEPEND=">=sys-libs/glibc-2.2.5
	virtual/libstdc++"
SLOT="${MAJOR}.${MINOR}"
MMV="${MAJOR}.${MINOR}"
KEYWORDS="~amd64 ia64 x86"
IUSE=""
RESTRICT="nostrip fetch"
S="${WORKDIR}/l_cc_c_${PV}"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from "
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

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
	instdir=/opt/intel/compiler${MMV//.}

	for x in opt/intel/*/*/bin/* ; do
		sed "s|<INSTALLDIR>|${instdir}|g" -i $x
	done

	# == SRC_BASE
	eval `grep "^[ ]*PACKAGEID=" ${S}/install.sh`

	# From UNTAG_SUPPORT() in 'install.sh'
	SUPPORTFILE=${S}/opt/intel/cc*/${MMV}*/doc/csupport
	if [ -f ${SUPPORTFILE} ]
	then
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<installpackageid\>@${PACKAGEID}@g ${SUPPORTFILE} > ${SUPPORTFILE}.abs
		mv ${SUPPORTFILE}.abs ${SUPPORTFILE}
		chmod 644 ${SUPPORTFILE}
	fi

	# From UNTAG_SUPPORT_IDB() in 'install.sh'
	SUPPORTFILE=${S}/opt/intel/idb*/${MMV}*/doc/idbsupport
	if [ -f ${SUPPORTFILE} ]
	then
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<INSTALLTIMECOMBOPACKAGEID\>@${PACKAGEID}@g ${SUPPORTFILE} > ${SUPPORTFILE}.abs
		mv ${SUPPORTFILE}.abs ${SUPPORTFILE}
		chmod 644 ${SUPPORTFILE}
	fi

	# These should not be executable
	find "${S}"/opt/intel/cc*/${MMV}*/{doc,man,include} -type f -exec chmod -x "{}" ";"
	find "${S}"/opt/intel/cc*/${MMV}*/lib -name \*.a -exec chmod -x "{}" ";"
	find "${S}"/opt/intel/idb*/${MMV}*/{doc,man} -type f -exec chmod -x "{}" ";"
}

src_install () {
	instdir=/opt/intel/compiler${MMV//.}
	dodoc ${S}/licenses/lgpltext
	dodoc ${S}/clicense
	dodir ${instdir}
	cp -pPR opt/intel/cc*/${MMV}*/* ${D}/${instdir}
	cp -pPR opt/intel/idb*/${MMV}*/* ${D}/${instdir}
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc-ifc || die
	exeinto ${instdir}/bin
	doexe ${FILESDIR}/${PVR}/icc || die
	doexe ${FILESDIR}/${PVR}/icpc || die
}

pkg_postinst () {
	instdir=/opt/intel/compiler${MMV//.}

	einfo "http://www.intel.com/software/products/compilers/clin/noncom.htm"
	einfo "From the above url you can get a free, non-commercial"
	einfo "license to use the Intel C++ Compiler emailed to you."
	einfo "You cannot run icc without this license file."
	einfo "Read the website for more information on this license."
	einfo
	einfo "Documentation can be found in ${instdir}/doc/"
	einfo
	einfo "You will need to place your license in ${instdir}/licenses/"
	einfo

	ewarn
	ewarn "Packages compiled with versions of icc older than 8.0 will need"
	ewarn "to be recompiled. Until you do that, old packages will"
	ewarn "work if you edit /etc/ld.so.conf and change '${instdir}'"
	ewarn "to '/opt/intel/compiler70' and run 'ldconfig.' Note that this edit"
	ewarn "won't persist and will require you to re-edit after each"
	ewarn "package you re-install."
	ewarn "BEFORE COMPILING IMPORTANT APPLICATIONS THAT YOUR"
	ewarn "SYSTEM DEPENDS ON, READ THE WARNING ABOVE."
	ewarn "THIS COULD RENDER YOUR SYSTEM UNUSABLE."
	ewarn "THIS IS A PROBLEM WITH INTEL'S SOFTWARE, _NOT_"
	ewarn "WITH GENTOO."

	ewarn "If 'icc' breaks, use 'iccbin' instead and report a bug."
	ewarn "Please use 'source /etc/profile' prior to merging any icc-enabled"
	ewarn "ebuilds."
}
