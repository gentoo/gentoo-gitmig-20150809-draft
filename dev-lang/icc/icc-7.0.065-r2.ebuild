# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-7.0.065-r2.ebuild,v 1.7 2003/05/10 22:51:35 avenj Exp $

S=${WORKDIR}

DESCRIPTION="Intel C++ Compiler - Intel's Pentium optimized compiler for Linux"

SRC_URI1="ftp://download.intel.com/software/products/compilers/downloads/l_cc_p_7.0.065.tar"
SRC_URI2="ftp://download.intel.co.jp/software/products/compilers/downloads/l_cc_p_7.0.065.tar"
SRC_URI="${SRC_URI1} ${SRC_URI2}"

HOMEPAGE="http://www.intel.com/software/products/compilers/clin/"

LICENSE="icc-7.0"

DEPEND="virtual/linux-sources
		>=sys-libs/glibc-2.2.4
		sys-apps/cpio
		app-arch/rpm"

RDEPEND="virtual/linux-sources
		>=sys-libs/glibc-2.2.4"

SLOT="7"
KEYWORDS="-* x86"
IUSE=""

src_compile() {
	# Keep disk space to a minimum
	rm -f intel-*.ia64.rpm

	mkdir opt

	for x in intel-*.i386.rpm
	do
		einfo "Extracting: ${x}"
		rpm2cpio ${x} | cpio --extract --make-directories --unconditional
	done

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
}

src_install () {
	dodoc lgpltext
	dodoc clicense
	cp -a opt ${D}

	# icc enviroment
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc-ifc
	# fix the issue with the primary icc executable
	exeinto /opt/intel/compiler70/ia32/bin
	doexe ${FILESDIR}/${PVR}/icc
}

pkg_postinst () {
	einfo
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
		ewarn "Packages compiled with older versions of icc will need"
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
