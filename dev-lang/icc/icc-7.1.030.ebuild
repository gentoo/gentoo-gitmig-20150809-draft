# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-7.1.030.ebuild,v 1.1 2003/10/14 05:08:09 drobbins Exp $

inherit rpm

S=${WORKDIR}
#what dir to use in FILESDIR
FILESV=7.1.029
DESCRIPTION="Intel C++ Compiler - Intel's Pentium optimized compiler for Linux"

SRC_URI1="ftp://download.intel.com/software/products/compilers/downloads/l_cc_pc_${PV}.tar"
SRC_URI2="ftp://download.intel.co.jp/software/products/compilers/downloads/l_cc_pc_${PV}.tar"
SRC_URI="${SRC_URI1} ${SRC_URI2}"

HOMEPAGE="http://www.intel.com/software/products/compilers/clin/"

LICENSE="icc-7.0"

DEPEND="virtual/linux-sources
		>=sys-libs/glibc-2.2.5"

RDEPEND="virtual/linux-sources
		>=sys-libs/glibc-2.2.5"

SLOT="7"
KEYWORDS="-* ~ia64 ~x86"
IUSE=""

RESTRICT="nostrip"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Keep disk space to a minimum
	if [ "$ARCH" = "x86" ]
	then
		rm -f intel-*.ia64.rpm
	else
		rm -f intel-*.i386.rpm
	fi

	rpm_unpack *.rpm

}
src_compile() {

	# From UNTAG_CFG_FILES in 'install'
	SD=${S}/opt/intel # Build DESTINATION
	RD=/opt/intel # Real DESTINATION
	for FILE in $(find $SD/compiler*/ia??/bin/ -regex '.*[ei][cf]p?c$\|.*cfg$\|.*pcl$\|.*vars[^/]*.c?sh$' 2>/dev/null)
	do
		sed s@\<INSTALLDIR\>@$RD@g ${FILE} > ${FILE}.abs
		mv -f ${FILE}.abs ${FILE}
		chmod 755 ${FILE}
	done

	# From UNTAG_SUPPORT in 'install'
	eval `grep "^[ ]*COMBOPACKAGEID=" install`

	for SUPPORTFILE in ${SD}/compiler*/docs/*support
	do
		einfo "Untagging: ${SUPPORTFILE}"
		sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
		mv $SUPPORTFILE.abs $SUPPORTFILE
		chmod 644 $SUPPORTFILE
	done

	# these should not be executable
	find "${SD}/compiler70/"{docs,man,training,ia32/include} -type f -exec chmod -x "{}" ";"
	find "${SD}/compiler70/ia32/lib" -name \*.a -exec chmod -x "{}" ";"

}

src_install () {
	dodoc lgpltext
	dodoc clicense
	cp -a opt ${D}

	insinto /etc/env.d
	if [ "$ARCH" = "x86" ]
	then
		newins ${FILESDIR}/${FILESV}/05icc-ifc-ia32 05icc-ifc || die
		# fix the processor name issue with the primary icc executable
		exeinto /opt/intel/compiler70/ia32/bin
		newexe ${FILESDIR}/${FILESV}/icc-ia32 icc
		newexe ${FILESDIR}/${FILESV}/icpc-ia32 icc
	else
		newins ${FILESDIR}/${FILESV}/05icc-ifc-ia64 05icc-ifc || die
		dodir /usr/bin
		dosym ../../opt/intel/compiler70/ia64/bin/eccbin /usr/bin/ecc
		dosym ../../opt/intel/compiler70/ia64/bin/ecpcbin /usr/bin/ecpc
	fi


}

pkg_postinst () {
	einfo "The ICC compiler for Itanium systems is called \"ecc\"."
	einfo "http://www.intel.com/software/products/compilers/clin/noncom.htm"
	einfo "From the above url you can get a free, non-commercial"
	einfo "license to use the Intel C++ Compiler emailed to you."
	einfo "You cannot run icc without this license file."
	einfo "Read the website for more information on this license."
	einfo
	einfo "Documentation can be found in /opt/intel/compiler70/docs/"
	einfo
	einfo "You will need to place your license in /opt/intel/licenses/"
	einfo

	ewarn
	ewarn "Packages compiled with versions of icc older than 7.0 will need"
	ewarn "to be recompiled. Until you do that, old packages will"
	ewarn "work if you edit /etc/ld.so.conf and change 'compiler70'"
	ewarn "to 'compiler60' and run 'ldconfig.' Note that this edit"
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
