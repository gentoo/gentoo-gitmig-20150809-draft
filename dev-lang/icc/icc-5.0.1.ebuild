# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-5.0.1.ebuild,v 1.6 2002/07/22 08:02:59 george Exp $

S=${WORKDIR}

DESCRIPTION="Intel C++ Compiler - The Pentium optimized compiler for linux"

#SRC_URI="cc010911rh71.tar"
#RESTRICT="fetch"

SRC_URI="http://www.intel.com/software/products/downloads/cc010911rh71.tar"

HOMEPAGE="http://www.intel.com/software/products/compilers/c50/linux/"

LICENSE="icc-5.0"

# Orginally I included app-shells/tcsh because there is one shell script that
# uses it but I found there is alse a ksh/bash version of that script provided
# but what documentation I read only referenced the tcsh version.
DEPEND=">=virtual/linux-sources-2.4
		>=sys-libs/glibc-2.2.2
		sys-apps/cpio
		app-arch/rpm"

RDEPEND=">=virtual/linux-sources-2.4
		>=sys-libs/glibc-2.2.2"

SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

src_compile() {
	mkdir opt

	for x in intel-subh-5.0.1-118.i386.rpm intel-icc-5.0.1-129.i386.rpm intel-ldb-5.0.1-119.i386.rpm
	do
		einfo "Extracting: ${x}"
		rpm2cpio ${x} | cpio --extract --make-directories --unconditional
	done

	SD=${S}/opt/intel
	RD=/opt/intel
	for FILE in $(ls $SD/compiler50/ia??/bin/*vars* 2>/dev/null) \
		$(ls $SD/compiler50/ia??/bin/*.cfg 2>/dev/null) \
		$(ls $SD/compiler50/ia??/bin/*.pcl 2>/dev/null) \
		$(ls $SD/compiler50/docs/*support* 2>/dev/null)
	do
		sed s@\<INSTALLDIR\>@$RD@g $FILE>${FILE}.abs
		mv -f ${FILE}.abs $FILE
		chmod 755 $FILE
	done

	# This should be for version 010911 only. More info at:
	# http://support.intel.com/support/performancetools/c/v5/linux/tti/csh.htm
	FILE="${S}/opt/intel/compiler50/ia32/bin/iccvars.csh"
	sed -e "s/=/ /" ${FILE} > ${FILE}.abs
	mv -f ${FILE}.abs $FILE
	chmod 755 $FILE
}

src_install () {
	dodoc lgpltext
	dodoc clicense
	cp -a opt ${D}

	# icc enviroment
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc
}

pkg_postinst () {
	einfo
	einfo "http://www.intel.com/software/products/compilers/c50/linux/71non_linuxlic.htm"
	einfo "From the above url you can get a free, non-time limited, non-commercial"
	einfo "personal use license key that comes with no support. You will need to read"
	einfo "and agree to the license and then fill in your info to have one emailed to"
	einfo "you. Read the website for the details."
	einfo
	einfo "Documentation can be found in /opt/intel/compiler50/doc/ ."
	einfo
	einfo "You will need to place your license in /opt/intel/licenses/ ."
	einfo
}
