# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-8.0.055.ebuild,v 1.1 2004/02/07 23:03:11 drobbins Exp $

inherit rpm

S=${WORKDIR}

DESCRIPTION="Intel C++ Compiler - Intel's Pentium optimized compiler for Linux"

SRC_BASE="l_cc_p_8.0.055"
SRC_PACK="${SRC_BASE}.tar.gz"
SRC_URI1="ftp://download.intel.com/software/products/compilers/downloads/${SRC_PACK}"
SRC_URI2="ftp://download.intel.co.jp/software/products/compilers/downloads/${SRC_PACK}"
SRC_URI="${SRC_URI1} ${SRC_URI2}"
# Both IA32 and IA64 can be installed here since all files have a distinct name.
INSTALL_DIR="/opt/intel/compiler80"

HOMEPAGE="http://www.intel.com/software/products/compilers/clin/"

LICENSE="icc-7.0"

DEPEND=">=sys-libs/glibc-2.2.5"

SLOT="8"
KEYWORDS="~ia64 ~x86"
IUSE=""

RESTRICT="nostrip"

src_unpack() {
	unpack ${SRC_PACK}
	cd ${WORKDIR}/${SRC_BASE}

	# Only use our architecture
	if [ "$ARCH" = "x86" ]
	then
		rm -f intel-*.ia64.rpm
	else
		rm -f intel-*.i386.rpm
	fi

	for x in *.rpm
	do
		# WORKDIR must be set properly for rpm_unpack()
		rpm_unpack ${WORKDIR}/${SRC_BASE}/${x}
	done
}

src_compile() {
	# From UNTAG_CFG_FILES() in 'install.sh'
	# Keep the Fortran bits(...)
	for FILE in $(find ${S}/opt/intel_*/bin/ -regex '.*[ei](cc|fort|fc|cpc)$\|.*cfg$\|.*pcl$\|.*vars[^/]*.c?sh$' 2>/dev/null)
	do
		sed s@\<INSTALLDIR\>@${INSTALL_DIR}@g ${FILE} > ${FILE}.abs
		mv -f ${FILE}.abs ${FILE}
		chmod 755 ${FILE}
	done

	# == SRC_BASE
	eval `grep "^[ ]*PACKAGEID=" ${SRC_BASE}/install.sh`

	# From UNTAG_SUPPORT() in 'install.sh'
	SUPPORTFILE=${S}/opt/intel_cc_80/doc/csupport
	if [ -f ${SUPPORTFILE} ]
	then
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<installpackageid\>@${PACKAGEID}@g ${SUPPORTFILE} > ${SUPPORTFILE}.abs
		mv ${SUPPORTFILE}.abs ${SUPPORTFILE}
		chmod 644 ${SUPPORTFILE}
	fi

	# From UNTAG_SUPPORT_IDB() in 'install.sh'
	SUPPORTFILE=${S}/opt/intel_idb_73/doc/idbsupport
	if [ -f ${SUPPORTFILE} ]
	then
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<INSTALLTIMECOMBOPACKAGEID\>@${PACKAGEID}@g ${SUPPORTFILE} > ${SUPPORTFILE}.abs
		mv ${SUPPORTFILE}.abs ${SUPPORTFILE}
		chmod 644 ${SUPPORTFILE}
	fi

	# These should not be executable
	find "${S}/opt/intel_cc_80/"{doc,man,include} -type f -exec chmod -x "{}" ";"
	find "${S}/opt/intel_cc_80/lib" -name \*.a -exec chmod -x "{}" ";"
	find "${S}/opt/intel_idb_73/"{doc,man} -type f -exec chmod -x "{}" ";"
}

src_install () {
	dodoc ${SRC_BASE}/lgpltext
	dodoc ${SRC_BASE}/clicense
	install -d ${D}/${INSTALL_DIR}
	cp -a opt/intel_cc_80/* ${D}/${INSTALL_DIR}
	cp -a opt/intel_idb_73/* ${D}/${INSTALL_DIR}
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc-ifc || die
	exeinto /opt/intel/compiler80/bin
	doexe ${FILESDIR}/${PVR}/icc
	doexe ${FILESDIR}/${PVR}/icpc
}

pkg_postinst () {
	einfo "http://www.intel.com/software/products/compilers/clin/noncom.htm"
	einfo "From the above url you can get a free, non-commercial"
	einfo "license to use the Intel C++ Compiler emailed to you."
	einfo "You cannot run icc without this license file."
	einfo "Read the website for more information on this license."
	einfo
	einfo "Documentation can be found in ${INSTALL_DIR}/doc/"
	einfo
	einfo "You will need to place your license in ${INSTALL_DIR}/licenses/"
	einfo

	ewarn
	ewarn "Packages compiled with versions of icc older than 8.0 will need"
	ewarn "to be recompiled. Until you do that, old packages will"
	ewarn "work if you edit /etc/ld.so.conf and change '${INSTALL_DIR}'"
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
